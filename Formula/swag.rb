class Swag < Formula
  desc "Automatically generate RESTful API documentation with Swagger 2.0 for Go"
  homepage "https://example.org/swag"
  version "2.0.0-rc6"
  url "http://127.0.0.1:8080/brew/bottles/swag--2.0.0-rc6.loongarch64.bottle.tar.gz"
  sha256 "350551a97010f032d5388b81a4ec4b61b754b980ad0c17125564f44dee3a6b63"

  def install
    bin.install "swag"
  end

  test do
    system "#{bin}/swag"
  end
end
