class File < Formula
  desc "Determine file type"
  homepage "https://example.org/file"
  version "5.46"
  url "http://127.0.0.1:8080/brew/bottles/file--5.46.loongarch64.bottle.tar.gz"
  sha256 "ceda6b52c2eb51e2ad0b2d98061ccce65abbb7a8bfeea340a87362bc162d7e2c"

  def install
    bin.install "file"
  end

  test do
    system "#{bin}/file"
  end
end
