class Xeve < Formula
  desc "Very fast Essential Video Encoder, MPEG-5 EVC (Essential Video Coding)"
  homepage "https://github.com/mpeg5/xeve"
  url "https://github.com/mpeg5/xeve/archive/refs/tags/v0.7.1.tar.gz"
  sha256 "5d1249212f431816b4723937c9ec8491b45ee1bb75c0f46692deaf7f59fbf19c"
  license "BSD-3-Clause"
  head "https://github.com/mpeg5/xeve.git", branch: "master"

  # Regex is needed to avoid picking up non-semver tags
  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "33aea44e119de6f4412889f8341f058b0cbee83aa091c0491673190155c93a0a"
  end

  depends_on "cmake" => :build

  resource "homebrew-testvideo", :test do
    url "https://github.com/grusell/svt-av1-homebrew-testdata/raw/main/video_64x64_yuv420p_25frames.yuv"
    sha256 "0c5cc90b079d0d9c1ded1376357d23a9782a704a83e01731f50ccd162e246492"
  end

  allow_network_access! :test

  def install
    system "cmake", "-S", ".", "-B", "build",
                    "-DSET_PROF=MAIN", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    testpath.install resource("homebrew-testvideo")
    system bin/"xeve_app", "-i", "video_64x64_yuv420p_25frames.yuv",
                           "-w", "64", "-h", "64", "--fps", "25", "-o", "out.evc"
    assert_path_exists testpath/"out.evc"
  end
end
