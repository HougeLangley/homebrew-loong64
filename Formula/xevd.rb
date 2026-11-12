class Xevd < Formula
  desc "Very fast Essential Video Decoder, MPEG-5 EVC (Essential Video Coding)"
  homepage "https://github.com/mpeg5/xevd"
  url "https://github.com/mpeg5/xevd/archive/refs/tags/v0.8.0.tar.gz"
  sha256 "258d626fbb6c7ea1677b4fb0ffed3eaca2ec312810d6a76f67359fdc16068472"
  license "BSD-3-Clause"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "2623971e9acb77d042bb5f535bb60937f96e35a1c32af2795c66e602805fb54e"
  end

  head "https://github.com/mpeg5/xevd.git", branch: "master"

  # Regex is needed to avoid picking up non-semver tags
  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end



  depends_on "cmake" => :build
  depends_on "xeve" => :test

  def install
    system "cmake", "-S", ".", "-B", "build",
                    "-DSET_PROF=MAIN", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    # 10 frames of 64x64 YUV420p, encoded by the sibling encoder to avoid an external bitstream
    (testpath/"in.yuv").binwrite("\x80" * (64 * 64 * 3 / 2 * 10))
    system formula_opt_bin("xeve")/"xeve_app", "-i", "in.yuv", "-w", "64", "-h", "64",
                                               "--fps", "25", "-o", "in.evc"

    system bin/"xevd_app", "-i", "in.evc", "-o", "out.yuv"
    assert_equal (testpath/"in.yuv").size, (testpath/"out.yuv").size
  end
end
