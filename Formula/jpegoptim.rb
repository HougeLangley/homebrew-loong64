class Jpegoptim < Formula
  desc "Utility to optimize JPEG files"
  homepage "https://github.com/tjko/jpegoptim"
  url "https://github.com/tjko/jpegoptim/releases/download/v1.5.6/jpegoptim-1.5.6.zip"
  sha256 "96cc4c6f6961235db41c8fc7b7b5baebc3179ddb24e96e87a03355beaf6014e2"
  license "GPL-3.0-or-later"
  head "https://github.com/tjko/jpegoptim.git", branch: "main"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "372c7a4c44d6b6ee1cc82a99141b808fea5f8b321c228736a60d5019bf9dd984"
  end

  depends_on "jpeg-turbo"

  def install
    system "./configure", *std_configure_args
    ENV.deparallelize # Install is not parallel-safe
    system "make", "install"
  end

  test do
    source = test_fixtures("test.jpg")
    assert_match "OK", shell_output("#{bin}/jpegoptim --noaction #{source}")
  end
end
