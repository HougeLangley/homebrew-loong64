class Glazepkg < Formula
  desc "See all your installed packages in one place. (Official package manage for RyokuArch)"
  homepage "https://example.org/glazepkg"
  version "0.6.10"
  url "http://127.0.0.1:8080/brew/bottles/glazepkg--0.6.10.loongarch64.bottle.tar.gz"
  sha256 "ff36fffd205cc6a3c4cfbefc2d08cc778ba2cb231746f487a125674b203ce2a3"

  def install
    bin.install "glazepkg"
  end

  test do
    system "#{bin}/glazepkg"
  end
end
