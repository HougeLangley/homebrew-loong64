class Restish < Formula
  desc "Restish is a CLI for interacting with REST-ish HTTP APIs with some nice features built-in"
  homepage "https://example.org/restish"
  version "2.3.0"
  url "http://127.0.0.1:8080/brew/bottles/restish--2.3.0.loongarch64.bottle.tar.gz"
  sha256 "8af2b244af3e66ca20c4ea5f86b84ee1b8c6745a384234a74d0f87e381e31cfe"

  def install
    bin.install "restish"
  end

  test do
    system "#{bin}/restish"
  end
end
