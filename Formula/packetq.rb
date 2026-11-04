class Packetq < Formula
  desc "SQL-like frontend to PCAP files"
  homepage "https://www.dns-oarc.net/tools/packetq"
  url "https://www.dns-oarc.net/files/packetq/packetq-1.8.0.tar.gz"
  sha256 "d89be327a505a86af0a76c3e41529998b75ebee10bd86e0c0b7f907666f9c741"
  license "GPL-3.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?packetq[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "6a3f5d238397d068bdbf28e9663d67b418dd7307533a48118704abef822029ae"
  end

  depends_on "pkgconf" => :build
  depends_on "dnswire"
  depends_on "libmaxminddb"
  depends_on "protobuf-c"
  depends_on "tinyframe"

  on_linux do
    depends_on "zlib-ng-compat"
  end

  deny_network_access!

  def install
    system "./configure", *std_configure_args
    system "make", "install"
  end

  test do
    output = shell_output("#{bin}/packetq --csv -s 'select id from dns' -")
    assert_equal '"id"', output.chomp
  end
end
