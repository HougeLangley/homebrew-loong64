class Better-curl-saul < Formula
  desc "Did you know you have rights? The FOSS says you do... Better Curl Saul is my homemade CLI "
  homepage "https://example.org/better-curl-saul"
  version "0.3.4"
  url "http://127.0.0.1:8080/brew/bottles/better-curl-saul--0.3.4.loongarch64.bottle.tar.gz"
  sha256 "805e1c2236c2aa787b48ae995a9d5e6a8cd10963c983f14442bf891e01c6607f"

  def install
    bin.install "better-curl-saul"
  end

  test do
    system "#{bin}/better-curl-saul"
  end
end
