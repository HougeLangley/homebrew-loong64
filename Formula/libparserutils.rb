class Libparserutils < Formula
  desc "Library for building efficient parsers"
  homepage "https://www.netsurf-browser.org/projects/libparserutils/"
  url "https://download.netsurf-browser.org/libs/releases/libparserutils-0.2.5-src.tar.gz"
  sha256 "317ed5c718f17927b5721974bae5de32c3fd6d055db131ad31b4312a032ed139"
  license "MIT"
  compatibility_version 1
  head "git://git.netsurf-browser.org/libparserutils.git", branch: "master"

  livecheck do
    url :homepage
    regex(/href=.*?libparserutils[._-]v?(\d+(?:\.\d+)+)[._-]src\.t/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "d3261ea643025b0f08e302f96ab2e037bcf3082edc3ffaffa0d551d4916b27c1"
  end

  depends_on "netsurf-buildsystem" => :build

  def install
    ENV.append "LDFLAGS", "-liconv" if OS.mac?

    args = %W[
      NSSHARED=#{Formula["netsurf-buildsystem"].opt_pkgshare}
      PREFIX=#{prefix}
    ]

    system "make", "install", "COMPONENT_TYPE=lib-shared", *args
    system "make", "install", "COMPONENT_TYPE=lib-static", *args

    pkgshare.install "test"
    (pkgshare/"test/utils").install "src/utils/utils.h"
  end

  test do
    system ENV.cc, pkgshare/"test/cscodec-utf8.c", "-I#{include}", "-L#{lib}", "-lparserutils", "-o", "cscodec-utf8"
    output = shell_output("#{testpath}/cscodec-utf8 #{pkgshare}/test/data/cscodec-utf8/UTF-8-test.txt")
    assert_match "PASS", output
  end
end
