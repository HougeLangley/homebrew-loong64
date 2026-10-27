class Procoder < Formula
  desc "Senior-developer discipline for AI coding agents. A commit gate that counts unchecked as f"
  homepage "https://example.org/procoder"
  version "3.9.2"
  url "http://127.0.0.1:8080/brew/bottles/procoder--3.9.2.loongarch64.bottle.tar.gz"
  sha256 "c1517530b5431793abf4110a9897832791f38bc5352d576350bbd0c178ec97b4"

  def install
    bin.install "procoder"
  end

  test do
    system "#{bin}/procoder"
  end
end
