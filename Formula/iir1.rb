class Iir1 < Formula
  desc "DSP IIR realtime filter library written in C++"
  homepage "https://berndporr.github.io/iir1/"
  url "https://github.com/berndporr/iir1/archive/refs/tags/1.11.0.tar.gz"
  sha256 "1a0f702f6787d9d38dd54e96ae82a4764766c506eeaff47f84f63eba9b5774e0"
  license "MIT"



  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "da6baf1a54a7c80ab57ba872723335a047d47b5a93915557e4fceb4c4bf7d633"
  end

  depends_on "cmake" => :build

  # Fix odd-order bandpass/bandstop setup with libc++ (macOS)
  patch do
    url "https://github.com/berndporr/iir1/commit/8bdfa0f2a53d0e63cb870b82c039476ffeb97487.patch?full_index=1"
    sha256 "03e9a3350311e503909b78dc397fb7f4a6817421f433ea9e575424c21e1900a5"
    type :unofficial
    resolves "https://github.com/berndporr/iir1/pull/73"
  end

  deny_network_access!

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    (pkgshare/"test").install "test/assert_print.h", "test/butterworth.cpp", "test/scipy.cpp",
                              "test/scipy.h", "test/signal.csv", *Dir["test/butterworth-*.csv"]
  end

  test do
    cp (pkgshare/"test").children, testpath
    system ENV.cxx, "-std=c++11", "butterworth.cpp", "scipy.cpp", "-o", "test", "-L#{lib}", "-liir"
    system "./test"
  end
end
