class Libgetdata < Formula
  desc "Reference implementation of the Dirfile Standards"
  homepage "https://getdata.sourceforge.net/"
  # TODO: Check if extra `make` call can be removed at version bump.
  url "https://downloads.sourceforge.net/project/getdata/getdata/0.11.0/getdata-0.11.0.tar.xz"
  sha256 "d16feae0907090047f5cc60ae0fb3500490e4d1889ae586e76b2d3a2e1c1b273"
  license "LGPL-2.1-or-later"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "85695513917fe9d1d0eadf32a76c6cdb9686e743dd0339e42e4b4d1eaeeb5c34"
  end


  depends_on "libtool"

  uses_from_macos "perl"

  on_linux do
    depends_on "zlib-ng-compat"
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

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--prefix=#{prefix}",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--disable-fortran",
                          "--disable-fortran95",
                          "--disable-php",
                          "--disable-python",
                          "--without-liblzma",
                          "--without-libzzip"

    ENV.deparallelize # can't open file: .libs/libgetdatabzip2-0.11.0.so (No such file or directory)
    system "make"
    # The Makefile seems to try to install things in the wrong order.
    # Remove this when the following PR is merged/resolved and lands in a release:
    # https://github.com/ketiltrout/getdata/pull/6
    system "make", "-C", "bindings/perl", "install-nodist_perlautogetdataSCRIPTS"
    system "make", "install"
  end

  test do
    assert_match "GetData #{version}", shell_output("#{bin}/checkdirfile --version", 1)
  end
end
