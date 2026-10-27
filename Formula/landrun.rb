class Landrun < Formula
  desc "Run any Linux process in a secure, unprivileged sandbox using Landlock. Think firejail, bu"
  homepage "https://example.org/landrun"
  version "0.1.17"
  url "http://127.0.0.1:8080/brew/bottles/landrun--0.1.17.loongarch64.bottle.tar.gz"
  sha256 "220edd242c0f9d88feddba9c56dc659f7eab7557e311949d9af4e8c79838c32f"

  def install
    bin.install "landrun"
  end

  test do
    system "#{bin}/landrun"
  end
end
