class Libstatgrab < Formula
  desc "Provides cross-platform access to statistics about the system"
  homepage "https://libstatgrab.org/"
  url "https://github.com/libstatgrab/libstatgrab/releases/download/LIBSTATGRAB_0_92_1/libstatgrab-0.92.1.tar.gz"
  sha256 "5688aa4a685547d7174a8a373ea9d8ee927e766e3cc302bdee34523c2c5d6c11"
  license all_of: ["GPL-2.0-or-later", "LGPL-2.1-or-later"]

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "f72f6d15cd0f06a100790954d17680dcfc8d64b8cb3a8ed6e867daf81057fcf0"
  end

  livecheck do
    url :stable
    regex(/^LIBSTATGRAB[._-]v?(\d+(?:[._]\d+)+)$/i)
    strategy :git do |tags, regex|
      tags.map { |tag| tag[regex, 1]&.tr("_", ".") }
    end
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

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-silent-rules", *std_configure_args
    system "make", "install"
  end

  test do
    system bin/"statgrab"
  end
end
