class Soft-serve < Formula
  desc "Mighty, self-hostable Git server for the command-line"
  homepage "https://example.org/soft-serve"
  version "0.12.4"
  url "http://127.0.0.1:8080/brew/bottles/soft-serve--0.12.4.loongarch64.bottle.tar.gz"
  sha256 "7f06a99dec6883d52d40d8fb20993776c34e247778a6d7e629c6811f4dbffad3"

  def install
    bin.install "soft-serve"
  end

  test do
    system "#{bin}/soft-serve"
  end
end
