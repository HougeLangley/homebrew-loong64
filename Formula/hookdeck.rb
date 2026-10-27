class Hookdeck < Formula
  desc "Forward webhook events from Hookdeck to a local server"
  homepage "https://example.org/hookdeck"
  version "3.1.0"
  url "http://127.0.0.1:8080/brew/bottles/hookdeck--3.1.0.loongarch64.bottle.tar.gz"
  sha256 "f26dc4033cda6c1c2eaa6eb0c394b5077dc38f4237bc25dc5b2322b7c2ef4203"

  def install
    bin.install "hookdeck"
  end

  test do
    system "#{bin}/hookdeck"
  end
end
