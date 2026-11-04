class Ngrep < Formula
  desc "Network grep"
  homepage "https://github.com/jpr5/ngrep"
  url "https://github.com/jpr5/ngrep/archive/refs/tags/v1.49.0.tar.gz"
  sha256 "6c94b31681316b7469a3ace92d2aeec7c9f490bd6782453dff2ade0e289a3348"
  license "ngrep"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "bd414e88541ee63e6198ae6a3ae2a3dbebd070172204865c0cf1ec04ac7bee9c"
  end

  depends_on "libpcap"
  depends_on "pcre2"

  def install
    args = %w[
      --enable-ipv6
      --enable-pcre2
    ]
    args << "--with-pcap-includes=#{formula_opt_include("libpcap")}"

    system "./configure", *args, *std_configure_args
    system "make", "install"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ngrep -V")
  end
end
