class Filebrowser < Formula
  desc "Web File Browser"
  homepage "https://example.org/filebrowser"
  version "2.63.23"
  url "http://127.0.0.1:8080/brew/bottles/filebrowser--2.63.23.loongarch64.bottle.tar.gz"
  sha256 "ec8f5f2425c004328ba0d325d68988097197036ad0b625f8e118de12950d190f"

  def install
    bin.install "filebrowser"
  end

  test do
    system "#{bin}/filebrowser"
  end
end
