class Draco < Formula
  desc "3D geometric mesh and point cloud compression library"
  homepage "https://google.github.io/draco/"
  url "https://github.com/google/draco/archive/refs/tags/1.5.9.tar.gz"
  sha256 "5b84e0e212ccc7b03ace681760a65a66fe2481a5f54df65154cfc8f0cbb87148"
  license "Apache-2.0"
  compatibility_version 2


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "b2fef4c7305d217002a451be677d7fdfd3ce3ad74243a7c78cd849738b18471e"
  end

  depends_on "cmake" => :build

  deny_network_access!

  def install
    args = %W[
      -DBUILD_SHARED_LIBS=ON
      -DCMAKE_INSTALL_RPATH=#{rpath}
    ]

    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"

    pkgshare.install "testdata/cube_att.ply"
  end

  test do
    cp pkgshare/"cube_att.ply", testpath

    output = shell_output("#{bin}/draco_encoder -i cube_att.ply -o cube_att.drc")
    assert_path_exists testpath/"cube_att.drc"
    assert_match <<~EOS, output
      Encoder options:
        Compression level = 7
        Positions: Quantization = 11 bits
        Normals: Quantization = 8 bits
    EOS
  end
end
