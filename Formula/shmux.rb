class Shmux < Formula
  desc "Execute the same command on many hosts in parallel"
  homepage "https://github.com/shmux/shmux"
  url "https://github.com/shmux/shmux/archive/refs/tags/v1.0.3.tar.gz"
  sha256 "c9f8863e2550e23e633cf5fc7a9c4c52d287059f424ef78aba6ecd98390fb9ab"
  license "BSD-3-Clause"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "d33fc9c48fd25a3528e69236cd9a6631b90cd42b90e74996ee31edf0425e852c"
  end


  uses_from_macos "ncurses"

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system bin/"shmux", "-h"
  end
end
