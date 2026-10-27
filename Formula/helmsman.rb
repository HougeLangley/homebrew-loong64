class Helmsman < Formula
  desc "Helm Charts as Code tool"
  homepage "https://example.org/helmsman"
  version "4.0.5"
  url "http://127.0.0.1:8080/brew/bottles/helmsman--4.0.5.loongarch64.bottle.tar.gz"
  sha256 "ae190e70bc90f6dda6f65cb43052109ac6e805b3802f79b2569f0d590b66cf16"

  def install
    bin.install "helmsman"
  end

  test do
    system "#{bin}/helmsman"
  end
end
