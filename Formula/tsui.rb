class Tsui < Formula
  desc "TUI for configuring and monitoring Tailscale"
  homepage "https://example.org/tsui"
  version "0.2.0"
  url "http://127.0.0.1:8080/brew/bottles/tsui--0.2.0.loongarch64.bottle.tar.gz"
  sha256 "465b3111cb64ee74f34886e2e0a422a409eb1c9c75a642c0ad7c44e288adabb7"

  def install
    bin.install "tsui"
  end

  test do
    system "#{bin}/tsui"
  end
end
