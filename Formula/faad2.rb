class Faad2 < Formula
  desc "ISO AAC audio decoder"
  homepage "https://freewareadvancedaudio.github.io"
  url "https://github.com/FreewareAdvancedAudio/faad2/archive/refs/tags/2.11.4.tar.gz"
  sha256 "ee479ccbae4a8387ab696e6f21a481bd83fe3881471cafa81b4ae59d7d3aed43"
  license "GPL-2.0-or-later"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "5dfae438a30cea972ab4f960ac02a154d2193387804e19762f32658f5ecbe467"
  end

  depends_on "cmake" => :build

  deny_network_access!

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    output = shell_output("#{bin}/faad -i #{test_fixtures("test.m4a")} 2>&1")
    assert_match "LC AAC\t0.192 secs, 1 ch, 8000 Hz", output
  end
end
