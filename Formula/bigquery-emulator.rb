class Bigquery-emulator < Formula
  desc "Emulate a GCP BigQuery server on your local machine"
  homepage "https://example.org/bigquery-emulator"
  version "0.8.1"
  url "http://127.0.0.1:8080/brew/bottles/bigquery-emulator--0.8.1.loongarch64.bottle.tar.gz"
  sha256 "ea69fca0abc40637a719b28355a8006e9c5614277b9c2955948775eaf7298212"

  def install
    bin.install "bigquery-emulator"
  end

  test do
    system "#{bin}/bigquery-emulator"
  end
end
