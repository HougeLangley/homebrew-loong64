class Libdnet < Formula
  desc "Portable low-level networking library"
  homepage "https://github.com/ofalk/libdnet"
  url "https://github.com/ofalk/libdnet/archive/refs/tags/libdnet-1.18.2.tar.gz"
  sha256 "95611c6d2703f1772fc01ce74acf4ebcc4bcd4315cede35b343bb90dc43bfd8f"
  license "BSD-3-Clause"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "30a06e1d9c24a433cda365955c8d8f9fa7bebce88c02e4955e933f6e74f7a2d5"
  end

  compatibility_version 1

  livecheck do
    url :homepage
    regex(/^libdnet[._-]v?(\d+(?:\.\d+)+)$/i)
  end


  depends_on "pkgconf" => :build

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-check", *std_configure_args
    system "make", "install"
  end

  test do
    system bin/"dnet-config", "--version"
  end
end
