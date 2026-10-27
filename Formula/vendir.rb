class Vendir < Formula
  desc "Easy way to vendor portions of git repos, github releases, helm charts, docker image conte"
  homepage "https://example.org/vendir"
  version "0.46.3"
  url "http://127.0.0.1:8080/brew/bottles/vendir--0.46.3.loongarch64.bottle.tar.gz"
  sha256 "2e19c09ae3ce8460ef1e9ce7b30c5c9cddd4fc559e4ce3c3b5c771e5a9e011cc"

  def install
    bin.install "vendir"
  end

  test do
    system "#{bin}/vendir"
  end
end
