class Rtaudio < Formula
  desc "API for realtime audio input/output"
  homepage "https://github.com/thestk/rtaudio"
  url "https://github.com/thestk/rtaudio/archive/refs/tags/6.0.1.tar.gz"
  sha256 "7206c8b6cee43b474f43d64988fefaadfdcfc4264ed38d8de5f5d0e6ddb0a123"
  license "MIT"
  head "https://github.com/thestk/rtaudio.git", branch: "master"

  bottle do
    rebuild 3
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "8a00fe957b904d704f5bb762d9286bd36a157554d8ec112d7facbfa8c08af0bf"
  end



  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  on_linux do
    depends_on "alsa-lib"
  end

  def install
    ENV.cxx11
    system "./autogen.sh", "--no-configure"
    system "./configure", *std_configure_args
    system "make", "install"
    (pkgshare/"tests").install "tests/testall.cpp"
  end

  test do
    system ENV.cxx, pkgshare/"tests/testall.cpp", "-o", "test", "-std=c++11",
           "-I#{include}/rtaudio", "-L#{lib}", "-lrtaudio"
    system "./test"
  end
end
