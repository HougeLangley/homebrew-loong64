class Fpart < Formula
  desc "Sorts file trees and packs them into bags"
  homepage "https://www.fpart.org/"
  url "https://github.com/martymac/fpart/archive/refs/tags/fpart-1.7.1.tar.gz"
  sha256 "512a82320cf5418ed70416b96cd49aa51a5ae418e96482144683cad6609add2e"
  license "BSD-2-Clause"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "52a75df8bf8d873256cd49acc145f86ae7e97376f18b25ead0e5639a7aff0b5e"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build

  def install
    system "autoreconf", "--force", "--install", "--verbose"
    system "./configure", "--disable-silent-rules", *std_configure_args
    system "make", "install"
  end

  test do
    (testpath/"myfile1").write("")
    (testpath/"myfile2").write("")
    system bin/"fpart", "-n", "2", "-o", (testpath/"mypart"), (testpath/"myfile1"), (testpath/"myfile2")
    assert_path_exists testpath/"mypart.1"
    assert_path_exists testpath/"mypart.2"
    refute_path_exists testpath/"mypart.0"
    refute_path_exists testpath/"mypart.3"
  end
end
