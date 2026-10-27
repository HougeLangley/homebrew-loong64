class Docker-debug < Formula
  desc "Use new container attach on already container go on debug"
  homepage "https://example.org/docker-debug"
  version "0.7.11"
  url "http://127.0.0.1:8080/brew/bottles/docker-debug--0.7.11.loongarch64.bottle.tar.gz"
  sha256 "546b375684e5ed6496a3224ebae039f6da4d46ab9b158116b33962d385995956"

  def install
    bin.install "docker-debug"
  end

  test do
    system "#{bin}/docker-debug"
  end
end
