class Docker-ls < Formula
  desc "Tools for browsing and manipulating docker registries"
  homepage "https://example.org/docker-ls"
  version "0.5.1"
  url "http://127.0.0.1:8080/brew/bottles/docker-ls--0.5.1.loongarch64.bottle.tar.gz"
  sha256 "d57933c4289f07a0f2db9ab52796b21a5f280a7bb018ff97cdd2181c8616e426"

  def install
    bin.install "docker-ls"
  end

  test do
    system "#{bin}/docker-ls"
  end
end
