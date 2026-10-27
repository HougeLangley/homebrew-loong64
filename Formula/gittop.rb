class Gittop < Formula
  desc "A beautiful terminal UI for visualizing Git repository statistics, inspired by htop/btop."
  homepage "https://example.org/gittop"
  version "0.6.0"
  url "http://127.0.0.1:8080/brew/bottles/gittop--0.6.0.loongarch64.bottle.tar.gz"
  sha256 "8a3ab0710966d17e841015888fbf898f1ae9db77a0cb811ed183e64b3d28f151"

  def install
    bin.install "gittop"
  end

  test do
    system "#{bin}/gittop"
  end
end
