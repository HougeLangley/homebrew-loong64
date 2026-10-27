class Awsweeper < Formula
  desc "CLI tool for cleaning your AWS account"
  homepage "https://example.org/awsweeper"
  version "0.12.0"
  url "http://127.0.0.1:8080/brew/bottles/awsweeper--0.12.0.loongarch64.bottle.tar.gz"
  sha256 "91f16fe2dbf49936205f7644a802949bc4c55ed88b1693e6480550d8d94de49b"

  def install
    bin.install "awsweeper"
  end

  test do
    system "#{bin}/awsweeper"
  end
end
