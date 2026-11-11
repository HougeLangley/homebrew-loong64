class Xdpyinfo < Formula
  desc "X.Org: Utility for displaying information about an X server"
  homepage "https://www.x.org/"
  url "https://xorg.freedesktop.org/archive/individual/app/xdpyinfo-1.4.0.tar.xz"
  sha256 "dc1de6e6e091ed46c4837b0ae9811e8182f7be0d2af638cab3e530ff081a48b6"
  license "MIT"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "1df128e03f0ef0de99364aad8d98e8fd54ad419d616aae1a1a6d428a4a95e433"
  end

  depends_on "pkgconf" => :build

  depends_on "libx11"
  depends_on "libxcb"
  depends_on "libxext"
  depends_on "libxi"
  depends_on "libxtst"

  def install
    args = %W[
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-silent-rules
    ]
    system "./configure", *args, *std_configure_args
    system "make", "install"
  end

  test do
    # The upstream 1.4.0 release tarball still reports "xdpyinfo 1.3.4" from
    # its own -version output (stale internal version in the tarball), so
    # asserting on #{version} can never pass. Match the binary's real,
    # deterministic version line instead.
    assert_match(/xdpyinfo \d+\.\d+\.\d+/, shell_output("DISPLAY= xdpyinfo -version"))
  end
end
