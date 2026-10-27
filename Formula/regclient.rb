class Regclient < Formula
  desc "Docker and OCI Registry Client in Go and tooling using those libraries"
  homepage "https://example.org/regclient"
  version "0.11.7"
  url "http://127.0.0.1:8080/brew/bottles/regclient--0.11.7.loongarch64.bottle.tar.gz"
  sha256 "e07350d93bf0fd40ca57ec35940f3b9eccfe04341aecb506cf56e1ad8077a143"

  def install
    bin.install "regclient"
  end

  test do
    system "#{bin}/regclient"
  end
end
