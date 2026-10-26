class Mcfly < Formula
  desc "Fly through your shell history"
  homepage "https://example.org/mcfly"
  version "0.9.4"
  url "http://127.0.0.1:8080/brew/bottles/mcfly--0.9.4.loongarch64.bottle.tar.gz"
  sha256 "6f03b3d016e3ff5edede2b9eda14e3c047ba3fe4860f2f8f6243ec85af452efd"

  def install
    bin.install "mcfly"
  end

  test do
    system "#{bin}/mcfly"
  end
end
