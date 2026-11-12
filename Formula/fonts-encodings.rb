class FontsEncodings < Formula
  desc "Font encoding tables for libfontenc"
  homepage "https://gitlab.freedesktop.org/xorg/font/encodings"
  url "https://xorg.freedesktop.org/archive/individual/font/encodings-1.1.0.tar.xz"
  sha256 "9ff13c621756cfa12e95f32ba48a5b23839e8f577d0048beda66c67dab4de975"
  license :public_domain


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "7462e1f270ad4d5506937a6ec76b39d0ef4234c2f2bf5a2b227f86e6cdb3ffd5"
  end

  depends_on "font-util"   => :build
  depends_on "mkfontscale" => :build
  depends_on "util-macros" => :build

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}", "dist/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    configure_args = std_configure_args + %W[
      --with-fontrootdir=#{share}/fonts/X11
    ]

    system "./configure", "--build=loongarch64-unknown-linux-gnu", *configure_args
    system "make"
    system "make", "install"
  end

  test do
    assert_path_exists share/"fonts/X11/encodings/encodings.dir"
  end
end
