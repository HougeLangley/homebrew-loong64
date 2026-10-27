class Terraboard < Formula
  desc ":earth_africa: :clipboard:  A web dashboard to inspect Terraform States "
  homepage "https://example.org/terraboard"
  version "2.4.0"
  url "http://127.0.0.1:8080/brew/bottles/terraboard--2.4.0.loongarch64.bottle.tar.gz"
  sha256 "c515142a1863a902fec975861305cf7e561c06741e590fbf603869bdf0c7207a"

  def install
    bin.install "terraboard"
  end

  test do
    system "#{bin}/terraboard"
  end
end
