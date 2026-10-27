class Cosmos-server < Formula
  desc "☁️ The Most Secure and Easy Selfhosted Home Server. Take control of your data and privacy "
  homepage "https://example.org/cosmos-server"
  version "0.23.4"
  url "http://127.0.0.1:8080/brew/bottles/cosmos-server--0.23.4.loongarch64.bottle.tar.gz"
  sha256 "f6f89bcb489e5cc96e9e58c4a910462d3f80d0eab10dae3b561ad50c41e5063d"

  def install
    bin.install "cosmos-server"
  end

  test do
    system "#{bin}/cosmos-server"
  end
end
