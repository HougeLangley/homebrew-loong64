class Ogmtools < Formula
  desc "OGG media streams manipulation tools"
  homepage "https://www.bunkus.org/videotools/ogmtools/"
  url "https://www.bunkus.org/videotools/ogmtools/ogmtools-1.5.tar.bz2"
  sha256 "c8d61d1dbceb981dc7399c1a85e43b509fd3d071fb8d3ca89ea9385e6e40fdea"
  license "GPL-2.0-only"

  livecheck do
    url :homepage
    regex(/href=.*?ogmtools[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "87e8372f3cf7fd99bebdddf68f492eab3e521cfea7a9c8383330654a183a3645"
  end

  depends_on "libogg"
  depends_on "libvorbis"

  # Borrow patch from MacPorts
  patch :p0 do
    file "Patches/ogmtools/common.h.diff"
    type :unofficial
  end

  deny_network_access!

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}", "dist/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    ENV.cxx11

    ENV.append "CPPFLAGS", "-I#{formula_opt_include("libvorbis")}"
    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--mandir=#{man}", *std_configure_args

    system "make", "install", "LIBS=-L#{formula_opt_lib("libvorbis")} -lvorbis -lvorbisenc"
  end

  # Borrow warning from MacPorts
  def caveats
    <<~EOS
      Ogmtools has not been updated since 2004 and is no longer being developed,
      maintained or supported. There are several issues, especially on 64-bit
      architectures, which the author will not fix or accept patches for.
      Keep this in mind when deciding whether to use this software.
    EOS
  end

  test do
    srt = <<~EOS
      1
      00:00:01,000 --> 00:00:02,500
      Hello Homebrew

      2
      00:00:03,000 --> 00:00:04,000
      Second line

    EOS
    (testpath/"subs.srt").write srt

    system bin/"ogmmerge", "-o", "test.ogm", "subs.srt"
    assert_match %r{\(t1/serial \d+\) text/subtitle stream}, shell_output("#{bin}/ogminfo test.ogm")

    system bin/"ogmdemux", "test.ogm"
    assert_equal srt, (testpath/"test.ogm-t1.srt").read.gsub("\r\n", "\n")
  end
end
