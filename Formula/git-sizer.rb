class Git-sizer < Formula
  desc "Compute various size metrics for a Git repository, flagging those that might cause problem"
  homepage "https://example.org/git-sizer"
  version "1.5.0"
  url "http://127.0.0.1:8080/brew/bottles/git-sizer--1.5.0.loongarch64.bottle.tar.gz"
  sha256 "d53e2ae62064d74881310af24a7ddeb3a0e28fbf1856ef2e0b67b5343fd8903e"

  def install
    bin.install "git-sizer"
  end

  test do
    system "#{bin}/git-sizer"
  end
end
