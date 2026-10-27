class Gotestwaf < Formula
  desc "An open-source project in Golang to asess different API Security tools and WAF for detecti"
  homepage "https://example.org/gotestwaf"
  version "0.5.10"
  url "http://127.0.0.1:8080/brew/bottles/gotestwaf--0.5.10.loongarch64.bottle.tar.gz"
  sha256 "3b19c2aecd6750c2028eab6657a4b097b4637f32ae98fb846bcc4b17b3a58f0e"

  def install
    bin.install "gotestwaf"
  end

  test do
    system "#{bin}/gotestwaf"
  end
end
