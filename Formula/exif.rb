class Exif < Formula
  desc "Read, write, modify, and display EXIF data on the command-line"
  homepage "https://libexif.github.io/"
  url "https://github.com/libexif/exif/releases/download/exif-0_6_22-release/exif-0.6.22.tar.xz"
  sha256 "0fe268736e0ca0538d4af941022761a438854a64c8024a4175e57bf0418117b9"
  license "LGPL-2.1-or-later"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "4cbfaace5be5d6e1e38f7eae7857d2debcab5d8ead6f048d584a6a9fa8e72646"
  end

  livecheck do
    url :stable
    regex(/^exif[._-]v?(\d+(?:[._-]\d+)+)[._-]release$/i)
    strategy :git do |tags, regex|
      tags.filter_map { |tag| tag[regex, 1]&.tr("_", ".") }
    end
  end


  depends_on "pkgconf" => :build
  depends_on "libexif"
  depends_on "popt"

  deny_network_access!

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    args = %w[
      --disable-silent-rules
      --disable-nls
    ]

    system "./configure", "--build=loongarch64-unknown-linux-gnu", *args, *std_configure_args
    system "make", "install"
  end

  test do
    test_image = test_fixtures("test.jpg")
    assert_match "The data supplied does not seem to contain EXIF data.",
                 shell_output("#{bin}/exif #{test_image} 2>&1", 1)
  end
end
