class Cmark < Formula
  desc "Strongly specified, highly compatible implementation of Markdown"
  homepage "https://commonmark.org/"
  url "https://github.com/commonmark/cmark/archive/refs/tags/0.31.2.tar.gz"
  sha256 "f9bc5ca38bcb0b727f0056100fac4d743e768872e3bacec7746de28f5700d697"
  license "BSD-2-Clause"
  compatibility_version 1


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "17a93314e71aec1e57cc366ea8ae0a837054adf9b47c69a77fec0aa675abe9f2"
  end

  depends_on "cmake" => :build

  uses_from_macos "python" => :build

  deny_network_access!

  def install
    system "cmake", "-S", ".", "-B", "build", "-DBUILD_SHARED_LIBS=ON", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    output = pipe_output(bin/"cmark", "*hello, world*")
    assert_equal "<p><em>hello, world</em></p>", output.chomp
  end
end
