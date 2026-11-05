class Thrulay < Formula
  desc "Measure performance of a network"
  homepage "https://sourceforge.net/projects/thrulay/"
  url "https://downloads.sourceforge.net/project/thrulay/thrulay/0.9/thrulay-0.9.tar.gz"
  sha256 "373d5613dfe371f6b4f48fc853f6c27701b2981ba4100388c9881cb802d1780d"
  # Similar to BSD-3-Clause-LBNL (i.e. BSD-3-Clause with an additional default
  # contribution licensing clause) but different phrasing from the SPDX license
  license :cannot_represent

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "57e72a8e51b9596d97d9d540fc52225968a3c82e71880f1ded576657f73b89ef"
  end


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
    ENV.deparallelize
    system "make", "install"
  end

  test do
    # prints "thrulay/2 (client part) release 0.9rc1"
    system bin/"thrulay", "-V"
  end
end
