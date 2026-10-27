class Docker-buildx < Formula
  desc "Docker CLI plugin for extended build capabilities with BuildKit"
  homepage "https://example.org/docker-buildx"
  version "0.38.1"
  url "http://127.0.0.1:8080/brew/bottles/docker-buildx--0.38.1.loongarch64.bottle.tar.gz"
  sha256 "b1ddbddd92d21eefa35c3a343a9deb002d9b00b9f2277dcc0d9ee9127a4c5005"

  def install
    bin.install "docker-buildx"
  end

  test do
    system "#{bin}/docker-buildx"
  end
end
