class Seexpr < Formula
  desc "Embeddable expression evaluation engine"
  homepage "https://wdas.github.io/SeExpr/"
  url "https://github.com/wdas/SeExpr/archive/refs/tags/v3.0.1.tar.gz"
  sha256 "1e4cd35e6d63bd3443e1bffe723dbae91334c2c94a84cc590ea8f1886f96f84e"
  license "Apache-2.0"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end



  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "520f51e253d2bdcb190bd4589e0725d9ba481788d4bc0b1a504b70108bdc38cc"
  end

  depends_on "cmake" => :build
  depends_on "libpng"

  uses_from_macos "bison" => :build
  uses_from_macos "flex" => :build

  on_linux do
    depends_on "mesa"
    depends_on "mesa-glu"
  end

  deny_network_access!

  def install
    args = %w[
      -DBUILD_DOC=OFF
      -DENABLE_LLVM_BACKEND=OFF
      -DENABLE_QT5=OFF
      -DENABLE_SSE4=OFF
      -DUSE_PYTHON=OFF
    ]
    args << "-DCMAKE_INSTALL_RPATH=#{rpath};#{rpath(source: share/"SeExpr2/utils")}" if OS.mac?

    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    actual_output = shell_output("#{bin}/asciiGraph2 'x^3-8*x'").lines.map(&:rstrip).join("\n")
    roundoff = "#" if Hardware::CPU.arm? && (!OS.mac? || MacOS.version >= :ventura)
    expected_output = <<~EOS
                                    |        #
                              ##    |        #
                              ###   |
                             #  #   |        #
                             #  ##  |        #
                             #   #  |        #
                            ##   #  |        #
                            #    ## |        #
                            #     # |        #
                            #     # |        #
                            #     # |        #
                            #      #|       #
                           #       #|       #
                           #       #|       #
      ---------------------#-------##-------#---------------------
                           #        #       #
                           #        #       #
                           #        #       #
                           #        ##      #
                           #        |#     #
                          #         |#     #
                          #         |#     #
                          #         |##    #
                          #         | #    #
                          #         | #   #
                          #         | ##  #
                          #         |  #  #
                                    |  ####{roundoff}
                          #         |   ##
                          #         |
    EOS

    assert_equal expected_output.rstrip, actual_output
  end
end
