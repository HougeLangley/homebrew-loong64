class Gitea < Formula
  desc "Git with a cup of tea! Painless self-hosted all-in-one software development service, inclu"
  homepage "https://example.org/gitea"
  version "28.2.0"
  url "http://127.0.0.1:8080/brew/bottles/gitea--28.2.0.loongarch64.bottle.tar.gz"
  sha256 "79abb4223bef2c35e4abffe2d647228a750a683de3f3d0a0c0a4d98bd1dd339e"

  def install
    bin.install "gitea"
  end

  test do
    system "#{bin}/gitea"
  end
end
