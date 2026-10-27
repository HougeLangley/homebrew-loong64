class Chief < Formula
  desc "Build big projects with Claude. Chief breaks your work into tasks and runs Claude Code in "
  homepage "https://example.org/chief"
  version "0.8.0"
  url "http://127.0.0.1:8080/brew/bottles/chief--0.8.0.loongarch64.bottle.tar.gz"
  sha256 "0e305779f44e9fc8af1684e61fa22efee170b7a318883fdca35d00282cea72fe"

  def install
    bin.install "chief"
  end

  test do
    system "#{bin}/chief"
  end
end
