class Devpod < Formula
  desc "Codespaces but open-source, client-only and unopinionated: Works with any IDE and lets you"
  homepage "https://example.org/devpod"
  version "0.6.15"
  url "http://127.0.0.1:8080/brew/bottles/devpod--0.6.15.loongarch64.bottle.tar.gz"
  sha256 "eaff2f225c7048a8439d2d83ce308973005ca564b8c502b9437296c7037e563e"

  def install
    bin.install "devpod"
  end

  test do
    system "#{bin}/devpod"
  end
end
