class Subfinder < Formula
  desc "Subdomain discovery tool"
  homepage "https://example.org/subfinder"
  version "2.17.0"
  url "http://127.0.0.1:8080/brew/bottles/subfinder--2.17.0.loongarch64.bottle.tar.gz"
  sha256 "6be9925f1f3c44c806768b391e7a1e8d1aa0d0fea6155bbb7e712b9b0bc77d08"

  def install
    bin.install "subfinder"
  end

  test do
    system "#{bin}/subfinder"
  end
end
