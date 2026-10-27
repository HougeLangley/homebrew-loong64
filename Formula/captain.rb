class Captain < Formula
  desc "Captain - Convert your Git workflow to Docker :whale: containers"
  homepage "https://example.org/captain"
  version "1.1.3"
  url "http://127.0.0.1:8080/brew/bottles/captain--1.1.3.loongarch64.bottle.tar.gz"
  sha256 "7cd135e18ad7dd4a67cf91240c54099536f70c2b47b670c8f08308e5b5440f2a"

  def install
    bin.install "captain"
  end

  test do
    system "#{bin}/captain"
  end
end
