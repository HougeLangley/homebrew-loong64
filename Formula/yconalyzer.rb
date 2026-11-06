class Yconalyzer < Formula
  desc "TCP traffic analyzer"
  homepage "https://sourceforge.net/projects/yconalyzer/"
  url "https://downloads.sourceforge.net/project/yconalyzer/yconalyzer-1.0.4.tar.bz2"
  sha256 "3b2bd33ffa9f6de707c91deeb32d9e9a56c51e232be5002fbed7e7a6373b4d5b"
  license "BSD-3-Clause"


  # Last release on 2010-06-29. Also zero installs in last 90 days:
  # "install: 0 (30 days), 0 (90 days), 20 (365 days)"
  deprecate! date: "2026-06-05", because: :unmaintained
  disable! date: "2027-06-05", because: :unmaintained

  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "9a011ec41a97ac46edca7e5b15eb7373df31b8e48e6f9a6605dadd6602b25b0b"
  end

  uses_from_macos "libpcap"

  # Fix build issues issue on OS X 10.9/clang
  # Patch reported to upstream - https://sourceforge.net/p/yconalyzer/bugs/3/
  patch :p0 do
    file "Patches/yconalyzer/1.0.4.patch"
    type :unofficial
    resolves "https://sourceforge.net/p/yconalyzer/bugs/3/"
  end


  def install
    # Workaround for error: 'strptime' was not declared in this scope
    # Upstream is not maintained
    ENV.append_to_cflags "-include time.h"

    system "./configure", "--mandir=#{man}", *std_configure_args
    system "make"
    chmod 0755, "./install-sh"
    system "make", "install"
  end

  test do
    output = shell_output("#{bin}/yconalyzer -p 80 -r #{test_fixtures("test.pcap")}")
    assert_match "Avg Server Data: 311 bytes", output
  end
end
