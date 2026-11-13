class Flac123 < Formula
  desc "Command-line program for playing FLAC audio files"
  homepage "https://github.com/flac123/flac123"
  url "https://github.com/flac123/flac123/archive/refs/tags/v2.1.1.tar.gz"
  sha256 "c09676dce51383ce4fe7a553e67f4369918cf40ee6d922e585e50c11bce9e227"
  license "GPL-2.0-or-later"
  revision 1


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "e4c18a3b93e5a6ae223a0ffe706eb2b1bc7d66651317bc864ccdab16c3b09fdb"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build

  depends_on "flac"
  depends_on "libao"
  depends_on "libogg"
  depends_on "popt"

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "buildaux/#{cf}", "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}", "dist/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    ENV["ACLOCAL"] = "aclocal"
    ENV["AUTOMAKE"] = "automake"
    system "aclocal"
    system "automake", "--add-missing"
    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--prefix=#{prefix}"
    system "make", "install", "CC=#{ENV.cc}"
  end

  test do
    driver = OS.mac? ? "macosx" : "oss"
    system bin/"flac123", "-d=#{driver}"
  end
end
