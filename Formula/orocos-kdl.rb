class OrocosKdl < Formula
  desc "Orocos Kinematics and Dynamics C++ library"
  homepage "https://orocos.org/"
  url "https://github.com/orocos/orocos_kinematics_dynamics/archive/refs/tags/1.5.4.tar.gz"
  sha256 "b47c75b03d5980a8b3a5382ab1176ae552f2f5418ad42b0e530a4178e3e1c301"
  license "LGPL-2.1-or-later"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "c02a9f167178789251c52a77cf53254cab9c5c6e912e4fe4cf297773be17056f"
  end

  depends_on "cmake" => :build
  depends_on "eigen"

  deny_network_access!

  def install
    system "cmake", "-S", "orocos_kdl", "-B", "build",
                    "-DCMAKE_CXX_STANDARD=14",
                    "-DEIGEN3_INCLUDE_DIR=#{formula_opt_include("eigen")}/eigen3",
                    *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"test.cpp").write <<~CPP
      #include <kdl/frames.hpp>
      int main()
      {
        using namespace KDL;
        Vector v1(1.,0.,1.);
        Vector v2(1.,0.,1.);
        assert(v1==v2);
        return 0;
      }
    CPP

    system ENV.cxx, "test.cpp", "-std=c++14", "-I#{include}", "-L#{lib}", "-lorocos-kdl",
                    "-o", "test"
    system "./test"
  end
end
