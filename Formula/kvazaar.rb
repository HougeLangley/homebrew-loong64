class Kvazaar < Formula
  desc "Ultravideo HEVC encoder"
  homepage "https://github.com/ultravideo/kvazaar"
  url "https://github.com/ultravideo/kvazaar/archive/refs/tags/v2.3.2.tar.gz"
  sha256 "ddd0038696631ca5368d8e40efee36d2bbb805854b9b1dda8b12ea9b397ea951"
  license "BSD-3-Clause"
  head "https://github.com/ultravideo/kvazaar.git", branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "bf214e8d4cea4322b475dd9a922fdfcb57ff4f2bacf91f72502e8185650d5f8d"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  resource "homebrew-videosample", :test do
    url "https://samples.mplayerhq.hu/V-codecs/lm20.avi"
    sha256 "a0ab512c66d276fd3932aacdd6073f9734c7e246c8747c48bf5d9dd34ac8b392"
  end

  def install
    system "./autogen.sh"
    system "./configure", *std_configure_args
    system "make", "install"
  end

  test do
    # download small sample and try to encode it
    resource("homebrew-videosample").stage do
      system bin/"kvazaar", "-i", "lm20.avi", "--input-res", "16x16", "-o", "lm20.hevc"
      assert_path_exists Pathname.pwd/"lm20.hevc"
    end
  end
end
