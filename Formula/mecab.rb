class Mecab < Formula
  desc "Yet another part-of-speech and morphological analyzer"
  homepage "https://taku910.github.io/mecab/"
  # Canonical url is https://drive.google.com/uc?export=download&id=0B4y35FiV1wh7cENtOXlicTFaRUE
  url "https://deb.debian.org/debian/pool/main/m/mecab/mecab_0.996.orig.tar.gz"
  sha256 "e073325783135b72e666145c781bb48fada583d5224fb2490fb6c1403ba69c59"
  license any_of: ["GPL-2.0-only", "LGPL-2.1-only", "BSD-3-Clause"]

  livecheck do
    url :homepage
    regex(/mecab[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  conflicts_with "mecab-ko", because: "both install mecab binaries"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "7dde8c1142f50136eb6d9dc2458252e3052c01dad966961676276b912146948f"
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    # Put dic files in HOMEBREW_PREFIX/lib instead of lib
    inreplace "mecab-config.in", "@libdir@/mecab/dic", HOMEBREW_PREFIX/"lib/mecab/dic"
    inreplace "mecabrc.in", "@prefix@/lib/mecab/dic", HOMEBREW_PREFIX/"lib/mecab/dic"

    # Help old config scripts identify arm64 linux
    args = ["--build=aarch64-unknown-linux-gnu"] if OS.linux? && Hardware::CPU.arm64?

    # Manually install etc files to avoid overwriting any existing files
    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--sysconfdir=#{etc}", *args, *std_configure_args
    system "make", "install", "sysconfdir=#{prefix}/etc"
    etc.install (prefix/"etc").children
  end

  post_install_steps do
    mkdir_p "{{HOMEBREW_PREFIX}}/lib/mecab/dic"
  end

  test do
    assert_equal "#{HOMEBREW_PREFIX}/lib/mecab/dic", shell_output("#{bin}/mecab-config --dicdir").chomp
    return if OS.linux?

    require "utils/linkage"
    library = "/usr/lib/libiconv.2.dylib"
    assert Utils.binary_linked_to_library?(bin/"mecab", library), "No linkage with #{library}!"
  end
end
