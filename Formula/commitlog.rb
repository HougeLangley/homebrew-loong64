class Commitlog < Formula
  desc "Generate Changelogs from Commits (CLI)"
  homepage "https://example.org/commitlog"
  version "3.0.0"
  url "http://127.0.0.1:8080/brew/bottles/commitlog--3.0.0.loongarch64.bottle.tar.gz"
  sha256 "a99059ab9967185eef641b64afea5e251707168daf64a8f1676edf11f7ffe0fb"

  def install
    bin.install "commitlog"
  end

  test do
    system "#{bin}/commitlog"
  end
end
