class Libemf2svg < Formula
  desc "Microsoft (MS) EMF to SVG conversion library"
  homepage "https://github.com/kakwa/libemf2svg"
  url "https://github.com/kakwa/libemf2svg/archive/refs/tags/1.8.1.tar.gz"
  sha256 "5a4b0051a2e8a7f999ecc1bb3451032833dc4c4f1e4bc6d938e4d5b4bec19c10"
  license "GPL-2.0-only"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "0dea890364acb8b208396dec3679b9ec27b650442d1bb540b097fcf7bf738abe"
  end

  depends_on "cmake" => :build
  depends_on "fontconfig"
  depends_on "freetype"
  depends_on "libpng"

  uses_from_macos "libxml2"

  on_macos do
    depends_on "argp-standalone" => :build
  end

  resource "homebrew-testdata", :test do
    url "https://github.com/kakwa/libemf2svg/raw/1.1.0/tests/resources/emf/test-037.emf"
    sha256 "d2855fc380fc3f791da58a78937af60c77ea437b749702a90652615019a5abdf"
  end

  allow_network_access! :test

  def install
    args = %W[-DCMAKE_INSTALL_RPATH=#{rpath}]
    args << "-DEXTERNAL_ICONV=iconv" if OS.mac?
    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    resource("homebrew-testdata").stage do
      system bin/"emf2svg-conv", "-i", "test-037.emf", "-o", testpath/"test.svg"
    end
    assert_path_exists testpath/"test.svg"
  end
end
