class ClangBuildAnalyzer < Formula
  desc "Tool to analyze compilation time"
  homepage "https://github.com/aras-p/ClangBuildAnalyzer"
  url "https://github.com/aras-p/ClangBuildAnalyzer/archive/refs/tags/v1.6.0.tar.gz"
  sha256 "868a8d34ecb9b65da4e5874342062a12c081ce4385c7ddd6ce7d557a0c5c292d"
  license all_of: ["Unlicense", "Zlib", "MIT", "BSL-1.0", "BSD-3-Clause", "Apache-2.0",
                   "BSD-2-Clause", "Apache-2.0" => { with: "LLVM-exception" }]
  head "https://github.com/aras-p/ClangBuildAnalyzer.git", branch: "main"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "b9afda710df74f64551e0ee2b736399d0118d7045b7491656516328178162ba8"
  end

  depends_on "cmake" => :build
  uses_from_macos "llvm"

  deny_network_access!

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"test.cxx").write <<~CPP
      int main() {}
    CPP
    ENV.clang
    system ENV.cxx, "-c", "-ftime-trace", testpath/"test.cxx"
    system bin/"ClangBuildAnalyzer", "--all", testpath, "test.db"
    system bin/"ClangBuildAnalyzer", "--analyze", "test.db"
  end
end
