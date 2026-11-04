class Lightgbm < Formula
  desc "Fast, distributed, high performance gradient boosting framework"
  homepage "https://lightgbm.readthedocs.io/en/latest/"
  url "https://github.com/lightgbm-org/LightGBM.git",
      tag:      "v4.7.0",
      revision: "8f7036f03627054d5a54a6f965b13f4b9ff2cb63"
  license "MIT"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "1d4fd9ae45614d1a9dfc90c673c6b046b98bb48cc5e53d36c740ff3f3e0ff7e5"
  end

  depends_on "cmake" => :build

  on_macos do
    depends_on "libomp"
  end

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    pkgshare.install "examples"
  end

  test do
    cp_r (pkgshare/"examples/regression"), testpath
    cd "regression" do
      system bin/"lightgbm", "config=train.conf"
    end
  end
end
