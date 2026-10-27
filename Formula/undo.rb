class Undo < Formula
  desc "Undo what the last shell command did to the filesystem"
  homepage "https://example.org/undo"
  version "0.3.0"
  url "http://127.0.0.1:8080/brew/bottles/undo--0.3.0.loongarch64.bottle.tar.gz"
  sha256 "cedd4295ca6f6a8dc4a1a7468162b17488241ad8f98db8104f79035ca36e516f"

  def install
    bin.install "undo"
  end

  test do
    system "#{bin}/undo"
  end
end
