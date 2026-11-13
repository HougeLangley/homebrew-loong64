class Liboping < Formula
  desc "C library to generate ICMP echo requests"
  homepage "https://noping.cc/"
  url "https://noping.cc/files/liboping-1.10.0.tar.bz2"
  sha256 "eb38aa93f93e8ab282d97e2582fbaea88b3f889a08cbc9dbf20059c3779d5cd8"
  license "LGPL-2.1-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?liboping[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "b2d4dd328919cbdc00cfe4880c3f23e01b30ca2a90b07a2b1174bcb54bcd70d2"
  end

  uses_from_macos "ncurses"
  uses_from_macos "perl"

  # Fix -flat_namespace being used on Big Sur and later.
  patch do
    file "Patches/libtool/configure-pre-0.4.2.418-big_sur.diff"
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}", "dist/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--mandir=#{man}", *std_configure_args
    system "make", "install"

    # move the Perl-generated `Net::Oping.3pm` manpage to man3 dir
    if OS.linux?
      mv prefix/"man/man3/Net::Oping.3pm", man3
      rm_r prefix/"man"
    else
      mv prefix/"local/share/man/man3/Net::Oping.3pm", man3
      rm_r prefix/"local"
    end
  end

  def caveats
    "Run oping and noping sudo'ed in order to avoid the 'Operation not permitted'"
  end

  test do
    system bin/"oping", "-h"
    system bin/"noping", "-h"
  end
end
