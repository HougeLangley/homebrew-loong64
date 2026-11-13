class DirectxHeaders < Formula
  desc "Official DirectX headers available under an open source license"
  homepage "https://devblogs.microsoft.com/directx/"
  url "https://github.com/microsoft/DirectX-Headers/archive/refs/tags/v1.619.5.tar.gz"
  sha256 "24a0b7d8079a2dbbc90753c0d8bc812040d052acce2302e69a97c5d873b313b8"
  license "MIT"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "24d14b13e6b93a42201aecabd0d9673ab55550eee66cc3ed904fda2a535b5989"
  end

  depends_on "meson" => :build
  depends_on "ninja" => :build
  def install
    system "meson", "setup", "build", "-Dbuild-test=false", *std_meson_args
    system "meson", "compile", "-C", "build"
    system "meson", "install", "-C", "build"
  end

  test do
    header = include/"directx/d3d12.h"
    assert_predicate header, :file?
    assert_operator header.size, :>, 0
    assert_match "D3D12", header.read
  end
end
