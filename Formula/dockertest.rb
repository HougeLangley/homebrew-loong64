class Dockertest < Formula
  desc "Write better integration tests! Dockertest helps you boot up ephermal docker images for yo"
  homepage "https://example.org/dockertest"
  version "4.0.1"
  url "http://127.0.0.1:8080/brew/bottles/dockertest--4.0.1.loongarch64.bottle.tar.gz"
  sha256 "649002d97bb1ffc640831b0bbb962e11acbd3d30617a511c9bd7de1a04043e22"

  def install
    bin.install "dockertest"
  end

  test do
    system "#{bin}/dockertest"
  end
end
