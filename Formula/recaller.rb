class Recaller < Formula
  desc "A rapid fast, command-line app to recall your files & shell history with absolute precisio"
  homepage "https://example.org/recaller"
  version "0.5.1"
  url "http://127.0.0.1:8080/brew/bottles/recaller--0.5.1.loongarch64.bottle.tar.gz"
  sha256 "e8da27a3639afbf981544939fd5a036b8434a429bc049c1ae68eca9c7417702b"

  def install
    bin.install "recaller"
  end

  test do
    system "#{bin}/recaller"
  end
end
