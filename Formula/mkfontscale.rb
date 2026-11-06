class Mkfontscale < Formula
  desc "Create an index of scalable font files for X"
  homepage "https://www.x.org/"
  url "https://www.x.org/releases/individual/app/mkfontscale-1.2.4.tar.xz"
  sha256 "a01492a17a9b6c0ee3f92ee578850e305315b9f298da5f006a1cd4b51db01a5e"
  license "X11"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "cfc827598046492db33712f4e6f8ca7d2fbc335f7570630d1f81100d2f0ff0f4"
  end


  depends_on "pkgconf" => :build
  depends_on "xorgproto" => :build

  depends_on "freetype"
  depends_on "libfontenc"

  uses_from_macos "bzip2"

  on_linux do
    depends_on "zlib-ng-compat"
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    configure_args = %w[
      --with-bzip2
    ]

    system "./configure", "--build=loongarch64-unknown-linux-gnu", *configure_args, *std_configure_args
    system "make"
    system "make", "install"
  end

  test do
    system bin/"mkfontscale"
    assert_path_exists testpath/"fonts.scale"
  end
end
