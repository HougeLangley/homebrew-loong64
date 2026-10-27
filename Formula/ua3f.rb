class Ua3f < Formula
  desc "Advanced HTTP(S) Rewriting Proxy"
  homepage "https://example.org/ua3f"
  version "3.7.0"
  url "http://127.0.0.1:8080/brew/bottles/ua3f--3.7.0.loongarch64.bottle.tar.gz"
  sha256 "2b4ffb843892fc07af343d10755a36f94a206b6d69f61448aae87e616709a0c7"

  def install
    bin.install "ua3f"
  end

  test do
    system "#{bin}/ua3f"
  end
end
