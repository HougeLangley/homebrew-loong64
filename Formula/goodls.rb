class Goodls < Formula
  desc "CLI tool to download shared files and folders from Google Drive"
  homepage "https://example.org/goodls"
  version "3.4.0"
  url "http://127.0.0.1:8080/brew/bottles/goodls--3.4.0.loongarch64.bottle.tar.gz"
  sha256 "56e2c7d2074f92e78d0a9f6ca24164a694a71222089434c631f57040f0862aee"

  def install
    bin.install "goodls"
  end

  test do
    system "#{bin}/goodls"
  end
end
