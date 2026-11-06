class Lft < Formula
  desc "Layer Four Traceroute (LFT), an advanced traceroute tool"
  homepage "https://pwhois.org/lft/"
  url "https://pwhois.org/dl/index.who?file=lft-4.03.tar.gz"
  sha256 "d84aff0c2baf57a5c5b21fb3b228eed0ac0e12e5a676b3b3be13e34770b91d17"
  license "VOSTROM"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "eab83f262f38a756b188f71196e099473f7da8e6ddfd8cd41ec86d0996627368"
  end

  livecheck do
    url :homepage
    regex(/value=.*?lft[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  depends_on "pkgconf" => :build
  depends_on "c-ares"
  depends_on "ncurses"

  uses_from_macos "libpcap"

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", *std_configure_args
    system "make", "install"
  end

  test do
    output = shell_output("#{bin}/lft -S -d 443 brew.sh 2>&1", 1)
    assert_match(/LFT: (insufficient privileges|Failed to activate capture on device)/, output)
  end
end
