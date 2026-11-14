class Cups < Formula
  desc "Common UNIX Printing System"
  homepage "https://github.com/OpenPrinting/cups"
  # This is the author's fork of CUPS. Debian have switched to this fork:
  # https://lists.debian.org/debian-printing/2020/12/msg00006.html
  url "https://github.com/OpenPrinting/cups/releases/download/v2.4.20/cups-2.4.20-source.tar.gz"
  sha256 "ab4d9cd7f3e58060091d2b24972223d6401675f11c49b65abf4f6ef31dea22ff"
  license "Apache-2.0" => { with: "LLVM-exception" }
  revision 1
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "068fcd70ffdf0165cb5f04905ffb6ba160e7d05b644304d64589aa13ec592a8e"
  end

  head "https://github.com/OpenPrinting/cups.git", branch: "master"

  livecheck do
    url :stable
    regex(/^(?:release[._-])?v?(\d+(?:\.\d+)+(?:op\d*)?)$/i)
  end


  keg_only :provided_by_macos

  depends_on "pkgconf" => :build
  depends_on "openssl@4"

  on_linux do
    depends_on "zlib-ng-compat"
  end

  # Fix builds without DNS-SD support, upstream PR ref, https://github.com/OpenPrinting/cups/pull/1740
  patch do
    url "https://github.com/OpenPrinting/cups/commit/23a183b63a4c94ae7cd0f36c63ee7eb905be60fd.patch?full_index=1"
    sha256 "8168c6048065abea242af383171b08b4b16b58d7b9831819f75b05c0d52ae0c5"
    type :unofficial
    resolves "https://github.com/OpenPrinting/cups/pull/1740"
  end

  allow_network_access! :test

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "buildaux/#{cf}", "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}", "dist/#{cf}"].each do |rel|
        src = "/usr/share/libtool/build-aux/#{cf}"
        dest = buildpath/rel
        if dest.exist? && File.exist?(src)
          File.chmod(0644, dest)
          cp src, dest
        end
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--with-components=core",
                          "--with-tls=openssl",
                          *std_configure_args
    system "make", "install"
  end

  test do
    port = free_port.to_s
    pid = spawn "#{bin}/ippeveprinter", "-p", port, "Homebrew Test Printer"

    begin
      sleep 2
      assert_match("Homebrew Test Printer", shell_output("curl localhost:#{port}"))
    ensure
      Process.kill("TERM", pid)
      Process.wait(pid)
    end
  end
end
