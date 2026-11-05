class Slurm < Formula
  desc "Yet another network load monitor"
  homepage "https://github.com/mattthias/slurm/wiki/"
  url "https://github.com/mattthias/slurm/archive/refs/tags/upstream/0.4.4.tar.gz"
  sha256 "2f846c9aa16f86cc0d3832c5cd1122b9d322a189f9e6acf8e9646dee12f9ac02"
  license "GPL-2.0-or-later"

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "f714630a7aa22176df6cbf2cd48bda8e3bc27dc3f4065c9bd1016b871fc007be"
  end

  livecheck do
    url :stable
    regex(%r{^upstream/v?(\d+(?:\.\d+)+)$}i)
  end



  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkgconf" => :build

  uses_from_macos "ncurses"

  def install
    system "meson", "setup", "build", *std_meson_args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"
  end

  test do
    net_if = OS.mac? ? "en0" : "eth0"
    output = pipe_output("#{bin}/slurm -i #{net_if}", "q")
    assert_match "slurm", output
  end
end
