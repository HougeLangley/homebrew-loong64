class Libcpuid < Formula
  desc "Small C library for x86 CPU detection and feature extraction"
  homepage "https://github.com/anrieff/libcpuid"
  url "https://github.com/anrieff/libcpuid/releases/download/v0.8.2/libcpuid-0.8.2.tar.gz"
  sha256 "be05cbafa086850a15b7d6f6cee3e72ae73a2b2ac75c0b2c6fc77611dede73b8"
  license "BSD-2-Clause"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "5962cf4c519a75967cedb3804656301d2748db0f1acf1da682f70bb726ce8742"
  end

  head do
    url "https://github.com/anrieff/libcpuid.git", branch: "master"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  on_macos do
    depends_on arch: :x86_64

    # Can be undeprecated if upstream decides to support arm64 macOS
    # https://docs.brew.sh/Support-Tiers#future-macos-support
    # TODO: Make linux-only when removing macOS support
    deprecate! date: "2025-09-25", because: :unsupported
    disable! date: "2026-09-25", because: :unsupported
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}", "dist/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "autoreconf", "--force", "--install", "--verbose" if build.head?
    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-silent-rules", *std_configure_args
    system "make", "install"
  end

  test do
    system bin/"cpuid_tool"
    assert_path_exists testpath/"raw.txt"
    assert_path_exists testpath/"report.txt"
    assert_match "CPUID is present", File.read(testpath/"report.txt")
  end
end
