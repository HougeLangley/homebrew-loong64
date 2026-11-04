class GoogleAuthenticatorLibpam < Formula
  desc "PAM module for two-factor authentication"
  homepage "https://github.com/google/google-authenticator-libpam"
  url "https://github.com/google/google-authenticator-libpam/archive/refs/tags/1.11.tar.gz"
  sha256 "3ee08a6dd46aace7dba1c88cf47e9cd267447ccd1cd8be1d5a05fd0e6816062d"
  license "Apache-2.0"
  revision 1


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "29674d2e91d489453431c3e1edd2bcc9851a32cd9f2c3f441f2f24251e4b5af8"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "qrencode"

  on_linux do
    depends_on "linux-pam"
  end

  def install
    ENV.append "LDFLAGS", "-Wl,-rpath,#{Formula["qrencode"].lib}"
    system "./bootstrap.sh"
    system "./configure", *std_configure_args,
                          "--disable-silent-rules"
    system "make", "install"
  end

  def caveats
    <<~EOS
      Add 2-factor authentication for ssh:
        echo "auth required #{opt_lib}/security/pam_google_authenticator.so" \\
        | sudo tee -a /etc/pam.d/sshd

      Add 2-factor authentication for ssh allowing users to log in without OTP:
        echo "auth required #{opt_lib}/security/pam_google_authenticator.so" \\
        "nullok" | sudo tee -a /etc/pam.d/sshd

      (Or just manually edit /etc/pam.d/sshd)
    EOS
  end

  test do
    system bin/"google-authenticator", "--force", "--time-based",
           "--disallow-reuse", "--rate-limit=3", "--rate-time=30",
           "--window-size=3", "--no-confirm"
  end
end
