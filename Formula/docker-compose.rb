class Docker-compose < Formula
  desc "Isolated development environments using Docker"
  homepage "https://example.org/docker-compose"
  version "5.6.1"
  url "http://127.0.0.1:8080/brew/bottles/docker-compose--5.6.1.loongarch64.bottle.tar.gz"
  sha256 "9da5e382a442d608da7d303e573cc85a7fc99b5eb5c008edb43d97cf04922d81"

  def install
    bin.install "docker-compose"
  end

  test do
    system "#{bin}/docker-compose"
  end
end
