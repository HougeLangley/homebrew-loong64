class Git-town < Formula
  desc "High-level command-line interface for Git"
  homepage "https://example.org/git-town"
  version "24.1.0"
  url "http://127.0.0.1:8080/brew/bottles/git-town--24.1.0.loongarch64.bottle.tar.gz"
  sha256 "14be01f1de011a1487cb115728077198d72b55392eb3de95477ba60f8e9c7f53"

  def install
    bin.install "git-town"
  end

  test do
    system "#{bin}/git-town"
  end
end
