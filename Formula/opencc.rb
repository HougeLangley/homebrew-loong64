class Opencc < Formula
  desc "Simplified-traditional Chinese conversion tool"
  homepage "https://opencc.byvoid.com/"
  url "https://github.com/BYVoid/OpenCC/archive/refs/tags/ver.1.4.2.tar.gz"
  sha256 "8e5f5cf7fe195bd9b9be851adc9738c1ef7dc5c24441dd5878a56db4087a9a70"
  license "Apache-2.0"
  compatibility_version 2
  head "https://github.com/BYVoid/OpenCC.git", branch: "master"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "8be4996b8a801088e3bdbdac6c6d92bc4631ec5062950a4fcf819d5377584748"
  end

  depends_on "cmake" => :build
  depends_on "marisa"
  uses_from_macos "python" => :build

  deny_network_access!

  def install
    args = %W[
      -DCMAKE_INSTALL_RPATH=#{rpath}
      -DPYTHON_EXECUTABLE=#{which("python3")}
      -DUSE_SYSTEM_MARISA=ON
    ]

    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    input = "中国鼠标软件打印机"
    output = pipe_output(bin/"opencc", input)
    output = output.force_encoding("UTF-8") if output.respond_to?(:force_encoding)
    assert_match "中國鼠標軟件打印機", output

    # The jieba segmentation plugin is only built by default on macOS
    return unless OS.mac?

    assert_path_exists lib/"opencc/plugins"/shared_library("libopencc-jieba")
    input = "城堡里的士兵"
    output = pipe_output("#{bin}/opencc -c s2twp_jieba.json", input)
    output = output.force_encoding("UTF-8") if output.respond_to?(:force_encoding)
    assert_match "城堡裡的士兵", output
  end
end
