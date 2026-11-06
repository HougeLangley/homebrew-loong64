class Bindfs < Formula
  desc "FUSE file system for mounting to another location"
  homepage "https://bindfs.org/"
  url "https://bindfs.org/downloads/bindfs-1.18.4.tar.gz"
  sha256 "3266d0aab787a9328bbb0ed561a371e19f1ff077273e6684ca92a90fedb2fe24"
  license "GPL-2.0-or-later"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "9dc6e61788391d7547e372ff2e3c7c6fa09545702a71615605ede552e80db874"
  end

  livecheck do
    url "https://bindfs.org/downloads/"
    regex(/href=.*?bindfs[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  head do
    url "https://github.com/mpartel/bindfs.git", branch: "master"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "pkgconf" => :build
  depends_on "libfuse"
  depends_on :linux # on macOS, requires closed-source macFUSE

  deny_network_access!

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    configure = build.head? ? "./autogen.sh" : "./configure"
    args << "--build=loongarch64-unknown-linux-gnu"
    system configure, *std_configure_args
    system "make", "install"
  end

  test do
    system bin/"bindfs", "-V"
  end
end
