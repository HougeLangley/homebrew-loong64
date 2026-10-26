class Bottom < Formula
  desc "Graphical process monitor"
  homepage "https://example.org/bottom"
  version "0.14.9"
  url "http://127.0.0.1:8080/brew/bottles/bottom--0.14.9.loongarch64.bottle.tar.gz"
  sha256 "61ebc392cea49f1d10a4330b6db63f3db8e5c668eda949348f45f5a3aef21dd6"

  def install
    bin.install "bottom"
  end

  test do
    system "#{bin}/bottom"
  end
end
