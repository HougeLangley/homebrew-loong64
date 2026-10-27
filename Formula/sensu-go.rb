class Sensu-go < Formula
  desc "Simple. Scalable. Multi-cloud monitoring."
  homepage "https://example.org/sensu-go"
  version "6.15.0"
  url "http://127.0.0.1:8080/brew/bottles/sensu-go--6.15.0.loongarch64.bottle.tar.gz"
  sha256 "a58689a3cfbea411a9a764a81351f09bd4d252412f73db45cbd3e791729c6a98"

  def install
    bin.install "sensu-go"
  end

  test do
    system "#{bin}/sensu-go"
  end
end
