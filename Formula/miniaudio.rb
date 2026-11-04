class Miniaudio < Formula
  desc "Audio playback and capture library"
  homepage "https://miniaud.io"
  url "https://github.com/mackron/miniaudio/archive/refs/tags/0.11.25.tar.gz"
  sha256 "b900edcffe979816e2560a0580b9b1216d674b4f17fbadeca8f777a7f8ab0274"
  license any_of: [:public_domain, "MIT-0"]


  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "03e8fe696e0c9e1743b6a709288248843983b3f8ba2551219cb22aae111f222c"
  end

  depends_on "cmake" => :build

  def install
    args = %w[
      -DMINIAUDIO_BUILD_EXAMPLES=OFF
      -DMINIAUDIO_BUILD_TESTS=OFF
      -DMINIAUDIO_INSTALL=ON
      -DBUILD_SHARED_LIBS=ON
      -DMINIAUDIO_NO_EXTRA_NODES=ON
    ]
    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <miniaudio/miniaudio.h>
      int main(void) {
        ma_context context;
        if (ma_context_init(NULL, 0, NULL, &context) != MA_SUCCESS) return 1;
        ma_context_uninit(&context);
        return 0;
      }
    C

    system ENV.cc, "test.c", "-o", "test", "-I#{include}", "-L#{lib}", "-lminiaudio", "-lm"
    system "./test"
  end
end
