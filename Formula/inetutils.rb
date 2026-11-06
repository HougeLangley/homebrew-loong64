class Inetutils < Formula
  desc "GNU utilities for networking"
  homepage "https://www.gnu.org/software/inetutils/"
  url "https://ftpmirror.gnu.org/inetutils/inetutils-2.8.tar.gz"
  mirror "https://ftp.gnu.org/gnu/inetutils/inetutils-2.8.tar.gz"
  sha256 "57b3cf4f77555992881e5ba2a09a63b05aa2c56342a60ed4305b5f45938390b5"
  license "GPL-3.0-or-later"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "8ee2a2ec84d717f54cfebd67751d9d7b4ac47440f29149b76cb642212d38afd0"
  end


  depends_on "help2man" => :build
  depends_on "libidn2"

  uses_from_macos "libxcrypt"
  uses_from_macos "ncurses"

  on_linux do
    depends_on "readline"
  end

  conflicts_with "telnet", because: "both install `telnet` binaries"
  conflicts_with "tnftp", because: "both install `ftp` binaries"
  conflicts_with "gping", because: "both install `gping` binaries"

  def noshadow
    # List of binaries that do not shadow macOS utils
    %w[dnsdomainname ftp rcp rexec rlogin rsh telnet]
  end

  def linux_conflicts
    # List of binaries that conflict with other common implementations
    list = %w[dnsdomainname hostname ifconfig] # net-tools
    list << "logger" # util-linux
    list << "ping" # iputils
    list << "whois" # whois
    list
  end

  def install
    # cc 命令改写（Makefile 里写死 cc 而非 $(CC) 时）
    Dir["Makefile", "**/Makefile", "**/GNUmakefile", "**/Makefile.*"].each do |mkf|
      next unless File.exist?(mkf)
      _m = File.read(mkf)
      _m = _m.gsub(/^(	| {0,4})(cc|gcc)([ 	])/) { "#{$1}$(CC)#{$3}" }
      File.write(mkf, _m)
    end
    # CMake 标志追加
    _cmflags = ["-DCMAKE_C_FLAGS=-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types", "-DCMAKE_CXX_FLAGS=-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types"].freeze
    # ENV.cc 追加
    _extra = "-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types".split
    Dir["Makefile", "GNUmakefile", "makefile", "src/Makefile"].each do |mkf|
      next unless File.exist?(mkf)
      _m = File.read(mkf)
      _m = _m.gsub(/-std=(c|gnu)(89|99|11|17|2x)/, "")
      File.write(mkf, _m)
    end
    # Makefile 里面追加（硬编码 CFLAGS 时 ENV 追加不生效）
    Dir["Makefile", "GNUmakefile", "makefile", "**/Makefile", "**/GNUmakefile", "**/makefile", "**/Makefile.*"].each do |mkf|
      next unless File.exist?(mkf)
      _m = File.read(mkf)
      _m = _m.sub(/^(CFLAGS[ \t]*[+:]?=)/) { $1 + " -std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types" }
      File.write(mkf, _m)
    end
    # CFLAGS 里面追加（configure 硬编码时 ENV 追加不生效）
    if File.exist?("configure")
      _cfg = File.read("configure")
      _cfg = _cfg.gsub(/^CFLAGS="([^"]*)"/) { 'CFLAGS="' + $1 + ' -std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types' }
      File.write("configure", _cfg)
    end
    ENV.append_to_cflags "-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types"
    system "./configure", "--disable-silent-rules",
                          "--with-idn",
                          "--program-prefix=g",
                          *std_configure_args
    system "make", "CFLAGS=-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types", "CXXFLAGS=-std=gnu++17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types",  "CC=/home/houge/infra/ci/bin/cc-compat",  "CC2=/home/houge/infra/ci/bin/cc-compat",  "CXX=/home/houge/infra/ci/bin/cxx-compat", "SUIDMODE=", "install"

    no_conflict = OS.mac? ? noshadow : []

    # Symlink server commands without 'g' prefix into sbin on Linux.
    # (ftpd, inetd, rexecd, rlogind, rshd, syslogd, talkd, telnetd, tftpd, uucpd)
    if OS.linux?
      libexec.find.each do |path|
        next if !path.executable? || path.directory?

        cmd = path.basename.to_s.sub(/^g/, "")
        sbin.install_symlink libexec/"g#{cmd}" => cmd
        man8.install_symlink man8/"g#{cmd}.8" => "#{cmd}.8"
      end
    end

    # Symlink commands without 'g' prefix into libexec/gnubin and
    # man pages into libexec/gnuman
    bin.find.each do |path|
      next if !path.executable? || path.directory?

      cmd = path.basename.to_s.sub(/^g/, "")
      no_conflict << cmd unless OS.mac?
      (libexec/"gnubin").install_symlink bin/"g#{cmd}" => cmd
      (libexec/"gnuman/man1").install_symlink man1/"g#{cmd}.1" => "#{cmd}.1"
    end
    (libexec/"gnubin").install_symlink "../gnuman" => "man"

    no_conflict -= linux_conflicts if OS.linux?
    # Symlink binaries that are not shadowing macOS utils or are
    # non-conflicting with common alternatives on Linux.
    no_conflict.each do |cmd|
      bin.install_symlink "g#{cmd}" => cmd
      man1.install_symlink "g#{cmd}.1" => "#{cmd}.1"
    end
  end

  def caveats
    s = ""
    on_macos do
      s += <<~EOS
        Only the following commands have been installed without the prefix 'g'.

            #{noshadow.sort.join("\n    ")}

        If you really need to use other commands with their normal names,
      EOS
    end
    on_linux do
      s += <<~EOS
        The following commands have been installed with the prefix 'g'.

            #{linux_conflicts.sort.join("\n    ")}

        If you really need to use these commands with their normal names,
      EOS
    end
    s += <<~EOS
      you can add a "gnubin" directory to your PATH from your bashrc like:

          PATH="#{opt_libexec}/gnubin:$PATH"
    EOS
    s
  end

  test do
    ftp = OS.mac? ? libexec/"gnubin/ftp" : bin/"ftp"
    output = pipe_output("#{ftp} -v", "open ftp.gnu.org\nanonymous\nls\nquit\n")
    assert_match "Connected to ftp.gnu.org.\n220 GNU FTP server ready", output
  end
end
