class Multi-gitter < Formula
  desc "Update multiple repositories in with one command"
  homepage "https://example.org/multi-gitter"
  version "0.64.0"
  url "http://127.0.0.1:8080/brew/bottles/multi-gitter--0.64.0.loongarch64.bottle.tar.gz"
  sha256 "95f34647cfe7698128c1dd47d0bb8f31b033a085960a5546b225881bbb0c9fc2"

  def install
    bin.install "multi-gitter"
  end

  test do
    system "#{bin}/multi-gitter"
  end
end
