class Clamz < Formula
  desc "Download MP3 files from Amazon's music store"
  homepage "https://code.google.com/archive/p/clamz/"
  url "https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/clamz/clamz-0.5.tar.gz"
  sha256 "5a63f23f15dfa6c2af00ff9531ae9bfcca0facfe5b1aa82790964f050a09832b"
  license "GPL-3.0-or-later"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "c6d236f91b684f03abe6d7359f3e0e7623159d96c04cbcda887424314c0623c8"
  end

  revision 1


  depends_on "pkgconf" => :build
  depends_on "libgcrypt"
  depends_on "libgpg-error"

  uses_from_macos "curl"
  uses_from_macos "expat"

  deny_network_access!

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/clamz --version 2>&1")
  end
end
