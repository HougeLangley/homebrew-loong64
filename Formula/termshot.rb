class Termshot < Formula
  desc "Creates screenshots based on terminal command output"
  homepage "https://example.org/termshot"
  version "0.6.1"
  url "http://127.0.0.1:8080/brew/bottles/termshot--0.6.1.loongarch64.bottle.tar.gz"
  sha256 "c65d5f677851b2c0bb1eb40b4275dbc100b7ce30820efad5bc885fe716f4265c"

  def install
    bin.install "termshot"
  end

  test do
    system "#{bin}/termshot"
  end
end
