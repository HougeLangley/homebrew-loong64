class Flowgrind < Formula
  desc "TCP measurement tool, similar to iperf or netperf"
  homepage "https://flowgrind.github.io"
  url "https://github.com/flowgrind/flowgrind/releases/download/flowgrind-0.8.2/flowgrind-0.8.2.tar.bz2"
  sha256 "432c4d15cb62d5d8d0b3509034bfb42380a02e3f0b75d16b7619a1ede07ac4f1"
  license "GPL-3.0-or-later"
  revision 4

  livecheck do
    url :stable
    regex(/flowgrind[._-]v?(\d+(?:\.\d+)+)/i)
    strategy :github_latest
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "ce3b854750cd6c354c3eda0b3b84ac6d402a6cc3421f7a7a60789b321aef4d3c"
  end

  head do
    url "https://github.com/flowgrind/flowgrind.git", branch: "next"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
  end

  depends_on "gsl"
  depends_on "xmlrpc-c"

  uses_from_macos "libpcap"

  on_linux do
    depends_on "util-linux"
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "buildaux/#{cf}", "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}", "dist/#{cf}"].each do |rel|
        src = "/usr/share/libtool/build-aux/#{cf}"
        dest = buildpath/rel
        if dest.exist? && File.exist?(src)
          File.chmod(0644, dest)
          cp src, dest
        end
      end
    end

    system "autoreconf", "--force", "--install", "--verbose" if build.head?
    system "./configure", "--build=loongarch64-unknown-linux-gnu", *std_configure_args, "--disable-silent-rules"
    system "make", "install"
  end

  test do
    system bin/"flowgrind", "--version"
  end
end
