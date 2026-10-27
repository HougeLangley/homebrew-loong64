class Dockerize < Formula
  desc "Utility to simplify running applications in docker containers"
  homepage "https://example.org/dockerize"
  version "0.25.4"
  url "http://127.0.0.1:8080/brew/bottles/dockerize--0.25.4.loongarch64.bottle.tar.gz"
  sha256 "7451962501ed2e381c2eada42ec315171b8450630f862ece674afabce931d2e8"

  def install
    bin.install "dockerize"
  end

  test do
    system "#{bin}/dockerize"
  end
end
