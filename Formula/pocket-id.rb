class Pocket-id < Formula
  desc "Open-source identity provider for secure user authentication"
  homepage "https://example.org/pocket-id"
  version "2.19.1"
  url "http://127.0.0.1:8080/brew/bottles/pocket-id--2.19.1.loongarch64.bottle.tar.gz"
  sha256 "3d9c55d33cff3c260267797619184a937986ddf3c891ba69558f8d14a182c5a4"

  def install
    bin.install "pocket-id"
  end

  test do
    system "#{bin}/pocket-id"
  end
end
