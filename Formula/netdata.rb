class Netdata < Formula
  desc "The fastest path to AI-powered full stack observability, even for lean teams."
  homepage "https://example.org/netdata"
  version "2.12.2"
  url "http://127.0.0.1:8080/brew/bottles/netdata--2.12.2.loongarch64.bottle.tar.gz"
  sha256 "d28ba02dcde3c082a28cf6e41304b09f94c59b04f68721e62aecfce278f92b9d"

  def install
    bin.install "netdata"
  end

  test do
    system "#{bin}/netdata"
  end
end
