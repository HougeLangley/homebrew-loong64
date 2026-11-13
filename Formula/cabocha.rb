class Cabocha < Formula
  desc "Yet Another Japanese Dependency Structure Analyzer"
  homepage "https://taku910.github.io/cabocha/"
  # Files are listed in https://drive.google.com/drive/folders/0B4y35FiV1wh7cGRCUUJHVTNJRnM
  url "https://distfiles.macports.org/cabocha/cabocha-0.69.tar.bz2"
  mirror "https://www.mirrorservice.org/sites/distfiles.macports.org/cabocha/cabocha-0.69.tar.bz2"
  sha256 "9db896d7f9d83fc3ae34908b788ae514ae19531eb89052e25f061232f6165992"
  license any_of: ["BSD-3-Clause", "LGPL-2.1-or-later"]

  livecheck do
    url :homepage
    regex(%r{>\d{4}/\d{2}/\d{2}\s+(\d+(?:\.\d+)+)<}i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "d53f819c0772f0b804dca29d130c618af32b0a2ce264b803264f902f44c942a8"
  end

  depends_on "crf++"
  depends_on "mecab"
  depends_on "mecab-ipadic"

  deny_network_access!

  def install
    ENV["LIBS"] = "-liconv" if OS.mac?

    args = %w[
      --with-charset=UTF8
      --with-posset=IPA
    ]
    # Help old config scripts identify arm64 linux
    args << "--build=aarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arm64?

    system "./configure", *args, *std_configure_args
    system "make", "install"
  end

  test do
    md5 = OS.mac? ? "md5" : "md5sum"
    result = pipe_output(md5, pipe_output(bin/"cabocha", "CaboCha はフリーソフトウェアです。", 0))
    assert_equal "a5b8293e6ebcb3246c54ecd66d6e18ee", result.chomp.split.first
  end
end
