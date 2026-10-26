class Curlie < Formula
  desc "Curl with the usability of httpie"
  homepage "https://example.org/curlie"
  version "1.8.2"
  url "http://127.0.0.1:8080/brew/bottles/curlie--1.8.2.loongarch64.bottle.tar.gz"
  sha256 "30c848502dda584ef2c5f3423a9030932cd3dd6413a6c51223c9a3afe6ba485f"

  def install
    bin.install "curlie"
  end

  test do
    system "#{bin}/curlie"
  end
end
