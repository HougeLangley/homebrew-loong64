class Gravity < Formula
  desc "Embeddable programming language"
  homepage "https://www.gravity-lang.org/"
  url "https://github.com/marcobambini/gravity/archive/refs/tags/0.9.9.tar.gz"
  sha256 "6b14bf45a0657c0e5a088e5dc941d72669b086847eb3474bcf65b37a522da548"
  license "MIT"
  head "https://github.com/marcobambini/gravity.git", branch: "master"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "bf8d508df2eca7a418c8a4265e04c25015f5735bc1d7235dda552116dd5d4a1a"
  end

  def install
    system "make"
    bin.install "gravity"
    doc.install Dir["docs/*"]
  end

  test do
    (testpath/"hello.gravity").write <<~GRAVITY
      func main() {
          System.print("Hello World!")
      }
    GRAVITY
    system bin/"gravity", "-c", "hello.gravity", "-o", "out.json"
    assert_equal "Hello World!\n", shell_output("#{bin}/gravity -q -x out.json")
    assert_equal "Hello World!\n", shell_output("#{bin}/gravity -q hello.gravity")
  end
end
