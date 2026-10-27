class Piko < Formula
  desc "An open-source alternative to Ngrok, designed to serve production traffic and be simple to"
  homepage "https://example.org/piko"
  version "0.10.1"
  url "http://127.0.0.1:8080/brew/bottles/piko--0.10.1.loongarch64.bottle.tar.gz"
  sha256 "ccbf3e8963ea8abf96eb8dfff0b388f8e1ee63a7dfe112af4b93448a3e90bb35"

  def install
    bin.install "piko"
  end

  test do
    system "#{bin}/piko"
  end
end
