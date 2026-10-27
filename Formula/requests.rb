class Requests < Formula
  desc "HTTP requests for Gophers"
  homepage "https://example.org/requests"
  version "0.26.2"
  url "http://127.0.0.1:8080/brew/bottles/requests--0.26.2.loongarch64.bottle.tar.gz"
  sha256 "e2f4b68ae9fe58173b98576c770d1bc7dbf12d75c0f48ddb987ca47dbb127c7a"

  def install
    bin.install "requests"
  end

  test do
    system "#{bin}/requests"
  end
end
