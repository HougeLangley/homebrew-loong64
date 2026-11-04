class Msmtp < Formula
  desc "SMTP client that can be used as an SMTP plugin for Mutt"
  homepage "https://marlam.de/msmtp/"
  url "https://marlam.de/msmtp/releases/msmtp-1.8.34.tar.xz"
  sha256 "84e8fe2a5a80a1ee7802013b3fbdb846a3f27a4163cf37a1c6d7c7f888873ead"
  license "GPL-3.0-or-later"

  livecheck do
    url "https://marlam.de/msmtp/download/"
    regex(/href=.*?msmtp[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "7c352ae5d0b22934af3508c7232cd3209ae7dbd7afa0448094bf6873c70e3ab0"
  end

  depends_on "pkgconf" => :build
  depends_on "gnutls"
  depends_on "libidn2"

  on_macos do
    depends_on "gettext"
  end

  def install
    # gnulib's base64.h uses `bool` without including
    # <stdbool.h>, assuming C23. Force the include for pre-C23 compilers.
    ENV.append_to_cflags "-include stdbool.h"

    system "./configure", "--disable-silent-rules", "--with-macosx-keyring", *std_configure_args
    system "make", "install"
    (pkgshare/"scripts").install "scripts/msmtpq"
  end

  test do
    system bin/"msmtp", "--help"
  end
end
