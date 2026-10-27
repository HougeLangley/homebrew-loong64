class Otel-cli < Formula
  desc "Tool for sending events from shell scripts & similar environments"
  homepage "https://example.org/otel-cli"
  version "0.4.5"
  url "http://127.0.0.1:8080/brew/bottles/otel-cli--0.4.5.loongarch64.bottle.tar.gz"
  sha256 "f081fc2b4cd6170f87f331df9b91df05afd4a51942e5b2fd3e1cddca7eac7aed"

  def install
    bin.install "otel-cli"
  end

  test do
    system "#{bin}/otel-cli"
  end
end
