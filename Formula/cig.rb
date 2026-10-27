class Cig < Formula
  desc "CLI app for checking the state of your git repositories"
  homepage "https://example.org/cig"
  version "0.1.5"
  url "http://127.0.0.1:8080/brew/bottles/cig--0.1.5.loongarch64.bottle.tar.gz"
  sha256 "13c1e217e5bcfc3594f0c8e9d877cd3d12428c741c71569c899f1bd1896562ac"

  def install
    bin.install "cig"
  end

  test do
    system "#{bin}/cig"
  end
end
