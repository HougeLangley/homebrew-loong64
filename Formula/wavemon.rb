class Wavemon < Formula
  desc "Ncurses-based monitoring application for wireless network devices on Linux"
  homepage "https://github.com/uoaerg/wavemon"
  url "https://github.com/uoaerg/wavemon/archive/refs/tags/v0.9.7.tar.gz"
  sha256 "768d7c580fcc592efcacac924dcfd2ebe131608f5c8ac67d36e35731e1ac683a"
  license all_of: ["GPL-3.0-or-later", "ISC"]


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "b39bd2932385aa8502dc6c2d553aabc15704e3ba7eb71a12ec9b6cb2826f4c46"
  end

  depends_on "pkgconf" => :build
  depends_on "libnl"
  depends_on :linux
  depends_on "ncurses"

  deny_network_access!

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", *std_configure_args
    system "make", "install"
  end

  test do
    # homebrew's linux runners don't have wifi kernel module
    assert_match "wavemon: option requires an argument -- 'i'", shell_output("#{bin}/wavemon -i 2>&1", 1)
  end
end
