class Ntl < Formula
  desc "C++ number theory library"
  homepage "https://libntl.org"
  url "https://libntl.org/ntl-11.6.0.tar.gz"
  sha256 "bc0ef9aceb075a6a0673ac8d8f47d5f8458c72fe806e4468fbd5d3daff056182"
  license "LGPL-2.1-or-later"

  livecheck do
    url "https://libntl.org/download.html"
    regex(/href=.*?ntl[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "64f303338024e75de9473f47ad6c1a48e7734e29f779b746c64ba5548bd85249"
  end

  depends_on "gmp"

  def install
    args = ["PREFIX=#{prefix}", "SHARED=on"]

    cd "src" do
      system "./configure", *args
      system "make"
      system "make", "install"
    end
  end

  test do
    (testpath/"square.cc").write <<~CPP
      #include <iostream>
      #include <NTL/ZZ.h>

      int main()
      {
          NTL::ZZ a;
          std::cin >> a;
          std::cout << NTL::power(a, 2);
          return 0;
      }
    CPP
    gmp = Formula["gmp"]
    flags = %W[
      -std=c++11
      -I#{include}
      -L#{gmp.opt_lib}
      -L#{lib}
      -lntl
      -lgmp
      -lpthread
    ]
    system ENV.cxx, "square.cc", "-o", "square", *flags
    assert_equal "4611686018427387904", pipe_output("./square", "2147483648")
  end
end
