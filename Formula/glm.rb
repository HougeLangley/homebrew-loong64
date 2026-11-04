class Glm < Formula
  desc "C++ mathematics library for graphics software"
  homepage "https://glm.g-truc.net/"
  url "https://github.com/g-truc/glm/archive/refs/tags/1.0.3.tar.gz"
  sha256 "6775e47231a446fd086d660ecc18bcd076531cfedd912fbd66e576b118607001"
  # GLM is licensed under The Happy Bunny License or MIT License
  license "MIT"
  compatibility_version 1
  head "https://github.com/g-truc/glm.git", branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "5275525f912e7949a573e71edb2720d567ab8eb3455c56281aa5d3d90a3fba46"
  end

  depends_on "cmake" => :build
  depends_on "doxygen" => :build

  deny_network_access!

  def install
    args = %w[
      -DGLM_BUILD_TESTS=OFF
      -DBUILD_SHARED_LIBS=ON
    ]

    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"

    include.install "glm"
    lib.install "cmake"
    (lib/"pkgconfig/glm.pc").write <<~PC
      prefix=#{prefix}
      includedir=${prefix}/include

      Name: GLM
      Description: OpenGL Mathematics
      Version: #{version.to_s.match(/\d+\.\d+\.\d+/)}
      Cflags: -I${includedir}
    PC

    cd "doc" do
      system "doxygen", "man.doxy"
      man.install "html"
    end
    doc.install Dir["doc/*"]
  end

  test do
    (testpath/"test.cpp").write <<~CPP
      #include <glm/vec2.hpp>// glm::vec2
      int main()
      {
        std::size_t const VertexCount = 4;
        std::size_t const PositionSizeF32 = VertexCount * sizeof(glm::vec2);
        glm::vec2 const PositionDataF32[VertexCount] =
        {
          glm::vec2(-1.0f,-1.0f),
          glm::vec2( 1.0f,-1.0f),
          glm::vec2( 1.0f, 1.0f),
          glm::vec2(-1.0f, 1.0f)
        };
        return 0;
      }
    CPP
    system ENV.cxx, "-I#{include}", testpath/"test.cpp", "-o", "test"
    system "./test"
  end
end
