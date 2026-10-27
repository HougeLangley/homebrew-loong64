class Osctrl-cli < Formula
  desc "Fast and efficient osquery management"
  homepage "https://example.org/osctrl-cli"
  version "0.6.1"
  url "http://127.0.0.1:8080/brew/bottles/osctrl-cli--0.6.1.loongarch64.bottle.tar.gz"
  sha256 "e90d7d16abddad43b20ef7f6541e44e0df27fa3bfc9422b802d20304deb45e6d"

  def install
    bin.install "osctrl-cli"
  end

  test do
    system "#{bin}/osctrl-cli"
  end
end
