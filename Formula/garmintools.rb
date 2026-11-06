class Garmintools < Formula
  desc "Interface to the Garmin Forerunner GPS units"
  homepage "https://code.google.com/archive/p/garmintools/"
  url "https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/garmintools/garmintools-0.10.tar.gz"
  sha256 "ffd50b7f963fa9b8ded3223c4786b07906c887ed900de64581a24ff201444cee"
  license "GPL-2.0-or-later"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "38b59f5b23224cc8bc3664549d9e3a9482a36b3f6236daba3e6ce92bc8ea1faf"
  end


  depends_on "libusb-compat"

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    # Fix flat namespace usage
    inreplace "configure", "${wl}-flat_namespace ${wl}-undefined ${wl}suppress", "${wl}-undefined ${wl}dynamic_lookup"

    args = []
    # Help old config scripts identify arm64 linux
    args << "--build=aarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    args << "--build=loongarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arch == :loongarch64

    system "./configure", *args, *std_configure_args
    system "make", "install"
  end

  test do
    system bin/"garmin_dump"
  end
end
