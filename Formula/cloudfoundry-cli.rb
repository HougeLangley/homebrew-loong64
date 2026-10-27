class Cloudfoundry-cli < Formula
  desc "Official command-line client for Cloud Foundry"
  homepage "https://example.org/cloudfoundry-cli"
  version "8.19.0"
  url "http://127.0.0.1:8080/brew/bottles/cloudfoundry-cli--8.19.0.loongarch64.bottle.tar.gz"
  sha256 "795f3510719fea2c5c8d287046b964eb535e7ba2454aea1de1764f08ea79556d"

  def install
    bin.install "cloudfoundry-cli"
  end

  test do
    system "#{bin}/cloudfoundry-cli"
  end
end
