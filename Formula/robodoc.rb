class Robodoc < Formula
  desc "Source code documentation tool"
  homepage "https://github.com/gumpu/ROBODoc"
  license "GPL-3.0-or-later"

  stable do
    url "https://web.archive.org/web/20260506043604/https://rfsber.home.xs4all.nl/Robo/archives/robodoc-4.99.44.tar.bz2"
    sha256 "3721c3be9668a1503454618ed807ae0fba5068b15bc0ea63846787d7e9e78c0f"

    # Fix macOS build (missing unistd.h include)
    patch do
      url "https://github.com/gumpu/ROBODoc/commit/0f8b35c42523810415bec70bb2200d2ecb41c82f.patch?full_index=1"
      sha256 "5fa0e63deaf9eb0eb82e53047a684159d572c116b96fcf4aa61777b663eb156d"
      type :backport
      resolves "https://github.com/gumpu/ROBODoc/issues/22"
    end
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "61337201373a6ba176abd25a750e2c726c07288624ec0b5ce88d7c44bdb5927c"
  end

  head do
    url "https://github.com/gumpu/ROBODoc.git", branch: "release"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  # Last release on 2021-01-28, dead homepage and low installs on deprecation date:
  # "install: 0 (30 days), 0 (90 days), 9 (365 days)"
  deprecate! date: "2026-09-16", because: :unmaintained
  disable! date: "2026-12-16", because: :unmaintained

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "autoreconf", "--force", "--install", "--verbose" if build.head?
    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-silent-rules", *std_configure_args
    system "make", "install"
  end

  test do
    cp_r Dir["#{doc}/Examples/PerlExample/*"], testpath
    system bin/"robodoc"
  end
end
