class Owfs < Formula
  desc "Monitor and control physical environment using Dallas/Maxim 1-wire system"
  homepage "https://owfs.org/"
  url "https://github.com/owfs/owfs/releases/download/v3.2p4/owfs-3.2p4.tar.gz"
  version "3.2p4"
  sha256 "af0a5035f3f3df876ca15aea13486bfed6b3ef5409dee016db0be67755c35fcc"
  license "GPL-2.0-only"



  depends_on "pkgconf" => :build
  depends_on "libftdi"
  depends_on "libusb"

  # Fix -flat_namespace being used on Big Sur and later.
  patch do
    file "Patches/libtool/configure-big_sur.diff"
    type :unofficial
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    ENV.append_to_cflags "-D_DARWIN_C_SOURCE" if OS.mac? && MacOS.version >= :sequoia

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-swig",
                          "--disable-owtcl",
                          "--disable-zero",
                          "--disable-owpython",
                          "--disable-owperl",
                          "--disable-swig",
                          "--enable-ftdi",
                          "--enable-usb",
                          *std_configure_args
    system "make", "install"
  end

  test do
    system bin/"owserver", "--version"
  end
end
