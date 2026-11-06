class Wavpack < Formula
  desc "Hybrid lossless audio compression"
  homepage "https://www.wavpack.com/"
  url "https://www.wavpack.com/wavpack-5.9.0.tar.bz2"
  sha256 "b0038f515d322042aaa6bd352d437729c6f5f904363cc85bbc9b0d8bd4a81927"
  license "BSD-3-Clause"
  compatibility_version 1

  # The first-party download page also links to `xmms-wavpack` releases, so
  # we have to avoid those versions.
  livecheck do
    url "https://www.wavpack.com/downloads.html"
    regex(%r{href=(?:["']/?|.*?/)wavpack[._-]v?(\d+(?:\.\d+)+)\.t}i)
  end


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "93b34831d2aef09a7e07fe094282b35d6dd56d14f7edb9de1a64cd9932fa62e3"
  end

  head do
    url "https://github.com/dbry/WavPack.git", branch: "master"
    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end


  def install
    args = %W[--prefix=#{prefix} --disable-dependency-tracking]

    # ARM assembly not currently supported
    # https://github.com/dbry/WavPack/issues/93
    args << "--disable-asm" if Hardware::CPU.arm?

    if build.head?
      system "./autogen.sh", *args
    else
      system "./configure", *args
    end

    system "make", "install"
  end

  test do
    system bin/"wavpack", test_fixtures("test.wav"), "-o", testpath/"test.wv"
    assert_path_exists testpath/"test.wv"
  end
end
