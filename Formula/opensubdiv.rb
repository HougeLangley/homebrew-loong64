class Opensubdiv < Formula
  desc "Open-source subdivision surface library"
  homepage "https://www.opensubdiv.org/"
  url "https://github.com/PixarAnimationStudios/OpenSubdiv/archive/refs/tags/v3_8_0.tar.gz"
  sha256 "e5eab30a97c7cce6b5a9905ae488981759c3d86cbce01d58a6c75e1fd9857a2b"
  license "Apache-2.0"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:[._]\d+)+)$/i)
    strategy :git do |tags, regex|
      tags.filter_map { |tag| tag[regex, 1]&.tr("_", ".") }
    end
  end



  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "9fc3de6444aaa57208c345376cbf92120574962a428a1dd88e35e21f2bf199ec"
  end

  depends_on "cmake" => :build
  depends_on "glfw"

  deny_network_access!

  def install
    glfw = Formula["glfw"]
    args = %W[
      -DNO_CLEW=1
      -DNO_CUDA=1
      -DNO_DOC=1
      -DNO_EXAMPLES=1
      -DNO_OMP=1
      -DNO_OPENCL=1
      -DNO_PTEX=1
      -DNO_TBB=1
      -DGLFW_LOCATION=#{glfw.opt_prefix}
    ]

    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    pkgshare.install bin/"tutorials/hbr_tutorial_0"
    rm_r("#{bin}/tutorials")
  end

  test do
    output = shell_output("#{pkgshare}/hbr_tutorial_0")
    assert_match "Created a pyramid with 5 faces and 5 vertices", output
  end
end
