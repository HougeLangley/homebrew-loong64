class Tendermint < Formula
  desc "BFT state machine replication for applications in any programming languages"
  homepage "https://example.org/tendermint"
  version "0.34.24"
  url "http://127.0.0.1:8080/brew/bottles/tendermint--0.34.24.loongarch64.bottle.tar.gz"
  sha256 "1e27889327ac062847a2896e4a17c60c2e42113174c099ba62f693b333fe165b"

  def install
    bin.install "tendermint"
  end

  test do
    system "#{bin}/tendermint"
  end
end
