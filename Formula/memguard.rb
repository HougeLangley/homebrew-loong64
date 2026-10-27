class Memguard < Formula
  desc "Software sandbox for storage of sensitive information in memory."
  homepage "https://example.org/memguard"
  version "0.23.0"
  url "http://127.0.0.1:8080/brew/bottles/memguard--0.23.0.loongarch64.bottle.tar.gz"
  sha256 "dd99131e6c216981ab796f0eea6c86431945cede9f858c60acfece5dbaa737df"

  def install
    bin.install "memguard"
  end

  test do
    system "#{bin}/memguard"
  end
end
