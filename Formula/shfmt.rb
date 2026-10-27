class Shfmt < Formula
  desc "Autoformat shell script source code"
  homepage "https://example.org/shfmt"
  version "3.14.1"
  url "http://127.0.0.1:8080/brew/bottles/shfmt--3.14.1.loongarch64.bottle.tar.gz"
  sha256 "23eccc974448e0334a262626f2ab880d0e309f63f3194809200767ed0214ba84"

  def install
    bin.install "shfmt"
  end

  test do
    system "#{bin}/shfmt"
  end
end
