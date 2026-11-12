class Vsftpd < Formula
  desc "Secure FTP server for UNIX"
  homepage "https://security.appspot.com/vsftpd.html"
  url "https://security.appspot.com/downloads/vsftpd-3.0.5.tar.gz"
  mirror "https://fossies.org/linux/misc/vsftpd-3.0.5.tar.gz"
  sha256 "26b602ae454b0ba6d99ef44a09b6b9e0dfa7f67228106736df1f278c70bc91d3"
  license "GPL-2.0-only"

  livecheck do
    url :homepage
    regex(/href=.*?vsftpd[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    rebuild 3
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "981564641a295197a557ef770874b114bd0608a1cd4766b0b2111f7dbd30bfd8"
  end

  uses_from_macos "perl" => :build

  on_linux do
    depends_on "libcap"
    depends_on "linux-pam"
  end

  # Patch to remove UTMPX dependency, locate macOS's PAM library, and
  # remove incompatible LDFLAGS. (reported to developer via email)
  patch do
    file "Patches/vsftpd/3.0.3.patch"
    type :unofficial
  end

  # Patch to disable all calls to setrlimit, as macOS, starting from
  # Monterey does not support this syscall. (reported to developer via
  # GitHub)
  patch do
    file "Patches/vsftpd/3.0.5.patch"
    type :unofficial
    resolves "https://github.com/djarosz/vsftpd/issues/3"
  end


  def install
    inreplace "defs.h", "/etc/vsftpd.conf", "#{etc}/vsftpd.conf"
    inreplace "tunables.c", "/etc", etc
    inreplace "tunables.c", "/var", var

    args = OS.linux? ? ["LIBS=-lcap -lpam"] : []
    system "make", *args

    # make install has all the paths hardcoded; this is easier:
    sbin.install "vsftpd"
    etc.install "vsftpd.conf"
    man5.install "vsftpd.conf.5"
    man8.install "vsftpd.8"
  end

  def caveats
    <<~EOS
      To use chroot, vsftpd requires root privileges, so you will need to run
      `sudo vsftpd`.
      You should be certain that you trust any software you grant root privileges.

      The vsftpd.conf file must be owned by root or vsftpd will refuse to start:
        sudo chown root #{HOMEBREW_PREFIX}/etc/vsftpd.conf
    EOS
  end

  service do
    run [opt_sbin/"vsftpd", etc/"vsftpd.conf"]
    require_root true
  end

  test do
    assert_match version.to_s, shell_output("#{sbin}/vsftpd -v 0>&1")
  end
end
