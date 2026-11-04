class IpRelay < Formula
  desc "TCP traffic shaping relay application"
  homepage "https://stewart.com.au/ip_relay/"
  url "https://stewart.com.au/ip_relay/ip_relay-0.71.tgz"
  sha256 "0cf6c7db64344b84061c64e848e8b4f547b5576ad28f8f5e67163fc0382d9ed3"
  license "GPL-2.0-only"

  livecheck do
    url :homepage
    regex(/href=.*?ip_relay[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "ab86c17f40aff215fc61783b6b147fa343e39bbbf07a7925c134f6e91e753d86"
  end

  def install
    bin.install "ip_relay.pl" => "ip_relay"
  end

  test do
    shell_output("#{bin}/ip_relay -b", 1)
  end
end
