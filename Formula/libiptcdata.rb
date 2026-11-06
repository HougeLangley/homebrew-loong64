class Libiptcdata < Formula
  desc "Virtual package provided by libiptcdata0"
  homepage "https://libiptcdata.sourceforge.net/"
  url "https://github.com/ianw/libiptcdata/releases/download/release_1_0_5/libiptcdata-1.0.5.tar.gz"
  sha256 "c094d0df4595520f194f6f47b13c7652b7ecd67284ac27ab5f219bc3985ea29e"
  license "LGPL-2.0-only"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "fd7c039790c4be665cd660815a56323ce22096aeaadeaa7bcc07bb341a6f7d16"
  end

  livecheck do
    url :stable
    regex(/^release[._-]v?(\d+(?:[._]\d+)+)$/i)
    strategy :git do |tags, regex|
      tags.filter_map { |tag| tag[regex, 1]&.tr("_", ".") }
    end
  end


  on_macos do
    depends_on "gettext"
  end

  # Fix -flat_namespace being used on Big Sur and later.
  patch do
    file "Patches/libtool/configure-big_sur.diff"
  end

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
    assert_match version.to_s, shell_output("#{bin}/iptc --version")
    assert_match "ModelVersion", shell_output("#{bin}/iptc --list")
  end
end
