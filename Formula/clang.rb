class Clang < Formula
  desc "C language family frontend for LLVM"
  homepage "https://clang.llvm.org/"
  url "https://github.com/llvm/llvm-project/releases/download/llvmorg-20.1.0/clang-20.1.0.src.tar.xz"
  sha256 "1a2b3c4d5e6f7a8b9c0d1e2f3a4b5c6d7e8f9a0b1c2d3e4f5a6b7c8d9e0f1a2b"
  license "Apache-2.0" => { with: "LLVM-exception" }

  depends_on "cmake" => :build
  depends_on "ninja" => :build
  depends_on "python@3.14" => :build
  depends_on "llvm"

  def install
    system "cmake", "-S", ".", "-B", "build",
           "-DCMAKE_INSTALL_PREFIX=#{prefix}",
           "-DLLVM_DIR=#{Formula["llvm"].opt_lib}/cmake/llvm"
    
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system bin/"clang", "--version"
  end
end
