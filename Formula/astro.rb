class Astro < Formula
  desc "To build and run Airflow DAGs locally and interact with the Astronomer API"
  homepage "https://example.org/astro"
  version "1.47.0"
  url "http://127.0.0.1:8080/brew/bottles/astro--1.47.0.loongarch64.bottle.tar.gz"
  sha256 "0a8ec9b8832ed9453bf5ce18969294699db6430c0cf27ec889746500b16a91b8"

  def install
    bin.install "astro"
  end

  test do
    system "#{bin}/astro"
  end
end
