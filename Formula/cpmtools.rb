class Cpmtools < Formula
  desc "Tools to access CP/M file systems"
  homepage "https://www.moria.de/~michael/cpmtools/"
  url "https://www.moria.de/~michael/cpmtools/files/cpmtools-2.23.tar.gz"
  sha256 "7839b19ac15ba554e1a1fc1dbe898f62cf2fd4db3dcdc126515facc6b929746f"
  license "GPL-3.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?cpmtools[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "ba520b9ff292e1f590216848c638282cf73032b7993c96fc042097d93cac1f6c"
  end

  depends_on "autoconf" => :build
  depends_on "libdsk"

  uses_from_macos "ncurses"

  deny_network_access!

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}", "dist/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    # The ./configure script that comes with the 2.21 tarball is too old to work with Xcode 12
    system "autoconf", "--force"
    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--prefix=#{prefix}", "--with-libdsk"

    bin.mkpath
    man1.mkpath
    man5.mkpath

    system "make", "install"
  end

  test do
    # make a disk image
    image = testpath/"disk.cpm"
    system bin/"mkfs.cpm", "-f", "ibm-3740", image

    # copy a file into the disk image
    src = testpath/"foo"
    src.write "a" * 128
    # Note that the "-T raw" is needed to make cpmtools work correctly when linked against libdsk:
    system bin/"cpmcp", "-T", "raw", "-f", "ibm-3740", image, src, "0:foo"

    # check for the file in the cp/m directory
    assert_match "foo", shell_output("#{bin}/cpmls -T raw -f ibm-3740 #{image}")

    # copy the file back out of the image
    dest = testpath/"bar"
    system bin/"cpmcp", "-T", "raw", "-f", "ibm-3740", image, "0:foo", dest
    assert_equal src.read, dest.read
  end
end
