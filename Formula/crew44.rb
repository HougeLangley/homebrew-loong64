class Crew44 < Formula
  desc "Orchestrate a crew of specialist AI agents in one local-first workspace.  Each role on its"
  homepage "https://example.org/crew44"
  version "0.8.1"
  url "http://127.0.0.1:8080/brew/bottles/crew44--0.8.1.loongarch64.bottle.tar.gz"
  sha256 "f6b31761d297fbd68540039a34f46edc69eb699628ebbdcbda340957efede420"

  def install
    bin.install "crew44"
  end

  test do
    system "#{bin}/crew44"
  end
end
