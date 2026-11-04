class Rgf < Formula
  desc "Regularized Greedy Forest library"
  homepage "https://github.com/RGF-team/rgf"
  url "https://github.com/RGF-team/rgf/archive/refs/tags/3.12.0.tar.gz"
  sha256 "c197977b8709c41aa61d342a01497d26f1ad704191a2a6b699074fe7ee57dc86"
  license "MIT"

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "b130085f50d3a2290d8b6ea3197b11e0c2415ac9c37d51d300a13e728f936ae6"
  end

  livecheck do
    url :stable
    strategy :github_latest
  end



  depends_on "cmake" => :build

  deny_network_access!

  def install
    cd "RGF" do
      mkdir "build" do
        system "cmake", *std_cmake_args, ".."
        system "cmake", "--build", "."
      end
      bin.install "bin/rgf"
      pkgshare.install "examples"
    end
  end

  test do
    cp_r (pkgshare/"examples/sample/."), testpath
    parameters = %w[
      algorithm=RGF
      train_x_fn=train.data.x
      train_y_fn=train.data.y
      test_x_fn=test.data.x
      reg_L2=1
      model_fn_prefix=rgf.model
    ]
    output = shell_output("#{bin}/rgf train_predict #{parameters.join(",")}")
    assert_match "Generated 20 model file(s)", output
  end
end
