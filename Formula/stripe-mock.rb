class Stripe-mock < Formula
  desc "Mock HTTP server that responds like the real Stripe API"
  homepage "https://example.org/stripe-mock"
  version "0.206.0"
  url "http://127.0.0.1:8080/brew/bottles/stripe-mock--0.206.0.loongarch64.bottle.tar.gz"
  sha256 "38dba08766f559efaef45dc198e5e25d34dd284a38c62eb2cbd1b9c9fdfc0945"

  def install
    bin.install "stripe-mock"
  end

  test do
    system "#{bin}/stripe-mock"
  end
end
