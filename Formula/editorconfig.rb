class Editorconfig < Formula
  desc "Maintain consistent coding style between multiple editors"
  homepage "https://editorconfig.org/"
  url "https://github.com/editorconfig/editorconfig-core-c/archive/refs/tags/v0.12.11.tar.gz"
  sha256 "9d8b420b56a969ea3cf784861c72d26fa0e158fa1494d732df2c8a1480d36a5c"
  license "BSD-2-Clause"
  head "https://github.com/editorconfig/editorconfig-core-c.git", branch: "master"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "67939ab7df7da4fd0228226f2e641335f515a1731404fd4fcd9d222617214ab1"
  end

  depends_on "cmake" => :build
  depends_on "pcre2"

  deny_network_access!

  def install
    system "cmake", "-S", ".", "-B", "build", "-DCMAKE_INSTALL_RPATH=#{rpath}", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system bin/"editorconfig", "--version"
  end
end
