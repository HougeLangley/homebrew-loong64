class Exomizer < Formula
  desc "File compressor optimized for decompression in 8-bit environments"
  homepage "https://bitbucket.org/magli143/exomizer/"
  url "https://bitbucket.org/magli143/exomizer/get/3.1.2.tar.gz"
  sha256 "01713f2ee39efc86cbe54bb6011613e097efc3bc532cdc640809e7589cd9c043"
  license all_of: [
    "Zlib",
    "GPL-3.0-or-later" => { with: "Bison-exception-2.2" },
  ]
  head "https://bitbucket.org/magli143/exomizer.git", branch: "master"

  livecheck do
    url :head
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "3ed03556ee15771f3bb86cd92550a2a15124da710b039c901bf6fe8a5b81be19"
  end

  def install
    cd "src" do
      system "make"
      bin.install %w[exobasic exomizer]
    end
  end

  test do
    (testpath/"test.txt").write("Hello World! Hello World! Hello World! Hello World!\n")
    system bin/"exomizer", "raw", "test.txt", "-o", "compressed.exo"
    system bin/"exomizer", "raw", "-d", "compressed.exo", "-o", "expanded.txt"
    assert_match "iHelo", File.binread("compressed.exo")
    assert_match File.read("test.txt"), File.read("expanded.txt")
  end
end
