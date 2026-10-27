class Gphotos-uploader-cli < Formula
  desc "Command-line tool to mass upload media folders to Google Photos"
  homepage "https://example.org/gphotos-uploader-cli"
  version "5.1.0"
  url "http://127.0.0.1:8080/brew/bottles/gphotos-uploader-cli--5.1.0.loongarch64.bottle.tar.gz"
  sha256 "bdade11b962d340937fa4db56526cf89e203c29e15898d02fa3191eef07b14f0"

  def install
    bin.install "gphotos-uploader-cli"
  end

  test do
    system "#{bin}/gphotos-uploader-cli"
  end
end
