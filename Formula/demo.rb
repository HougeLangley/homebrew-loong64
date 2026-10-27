class Demo < Formula
  desc "A framework for performing live pre-recorded command line demos in the wild 📼"
  homepage "https://example.org/demo"
  version "0.1.1"
  url "http://127.0.0.1:8080/brew/bottles/demo--0.1.1.loongarch64.bottle.tar.gz"
  sha256 "a24d82cb477d742905727b581962727aafc80bb661276510f32f02e40ed0bc3c"

  def install
    bin.install "demo"
  end

  test do
    system "#{bin}/demo"
  end
end
