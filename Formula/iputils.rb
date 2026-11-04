class Iputils < Formula
  desc "Set of small useful utilities for Linux networking"
  homepage "https://github.com/iputils/iputils"
  url "https://github.com/iputils/iputils/releases/download/20250605/iputils-20250605.zip"
  sha256 "66a8697da6b6696e8cd69e88d69a31c7b7a7cc6d6937cd1dfc84532c23a84f14"
  license all_of: ["GPL-2.0-or-later", "BSD-3-Clause"]
  head "https://github.com/iputils/iputils.git", branch: "master"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "4db8d06866c670b8a3fc149d410cad2f5116177ca2950fc7ae5bb7d4885042f5"
  end

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "libxslt"
  depends_on :linux

  def install
    args = %w[
      -DBUILD_MANS=true
      -DUSE_CAP=false
      -DSKIP_TESTS=true
    ]

    system "meson", "setup", "build", *args, *std_meson_args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ping -V")
  end
end
