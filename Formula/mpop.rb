class Mpop < Formula
  desc "POP3 client"
  homepage "https://marlam.de/mpop/"
  url "https://marlam.de/mpop/releases/mpop-1.4.23.tar.xz"
  sha256 "02fc2ff44f62b8fbf427ed6d8b16e0d374751198254fb1e6ad36eb6d9a938017"
  license "GPL-3.0-or-later"

  livecheck do
    url "https://marlam.de/mpop/download/"
    regex(/href=.*?mpop[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "e02e751e23c7dcd0da635653aa6437a0b2b3b71c8db4dd8288938dd430e09fa5"
  end

  depends_on "pkgconf" => :build
  depends_on "gnutls"
  depends_on "libidn2"

  on_macos do
    depends_on "gettext"
  end

  def install
    # gnulib's base64.h (vendored in 1.4.22) uses `bool` without including
    # <stdbool.h>, assuming C23. Force the include for pre-C23 compilers.
    ENV.append "CFLAGS", "-include stdbool.h"

    system "./configure", *std_configure_args
    system "make", "install"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mpop --version")
  end
end
