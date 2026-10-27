class Emp < Formula
  desc "CLI for Empire"
  homepage "https://example.org/emp"
  version "0.13.0"
  url "http://127.0.0.1:8080/brew/bottles/emp--0.13.0.loongarch64.bottle.tar.gz"
  sha256 "dc28acb6218107bc6f412237e74498905001db1b7c682cdec8271a015e638397"

  def install
    bin.install "emp"
  end

  test do
    system "#{bin}/emp"
  end
end
