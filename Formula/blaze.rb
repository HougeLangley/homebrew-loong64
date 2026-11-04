class Blaze < Formula
  desc "High-performance C++ math library for dense and sparse arithmetic"
  homepage "https://bitbucket.org/blaze-lib/blaze"
  url "https://bitbucket.org/blaze-lib/blaze/downloads/blaze-3.8.2.tar.gz"
  sha256 "4c4e1915971efbedab95790e4c5cf017d8448057fa8f8c62c46e1643bf72cbb1"
  license "BSD-3-Clause"
  head "https://bitbucket.org/blaze-lib/blaze.git", branch: "master"

  livecheck do
    url :head
  end


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "28861f6c4d7a5e3e62a108a5e379e4baaa8c1b82961d3cf6c02fdf0687088b81"
  end

  depends_on "cmake" => :build
  depends_on "openblas"

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"test.cpp").write <<~CPP
      #include <iostream>
      #include <blaze/Math.h>

      int main() {
          blaze::DynamicMatrix<int> A( 2UL, 3UL, 0 );
          A(0,0) =  1;
          A(0,2) =  4;
          A(1,1) = -2;

          blaze::StaticMatrix<int,3UL,2UL,blaze::columnMajor> B{
              { 3, -1 },
              { 0, 2 },
              { -1, 0 }
          };

          blaze::DynamicMatrix<int> C = A * B;
          std::cout << "C =\\n" << C;
      }
    CPP

    expected = <<~EOS
      C =
      (           -1           -1 )
      (            0           -4 )
    EOS

    system ENV.cxx, "test.cpp", "-std=c++14", "-I#{include}", "-o", "test"
    assert_equal expected, shell_output(testpath/"test")
  end
end
