class Iamy < Formula
  desc "AWS IAM import and export tool"
  homepage "https://example.org/iamy"
  version "2.4.0"
  url "http://127.0.0.1:8080/brew/bottles/iamy--2.4.0.loongarch64.bottle.tar.gz"
  sha256 "c2904012270742409cf439c2adaeba4780869b6ad3951f0840c71dbab7e08ba5"

  def install
    bin.install "iamy"
  end

  test do
    system "#{bin}/iamy"
  end
end
