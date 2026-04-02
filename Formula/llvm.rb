class Llvm < Formula
  desc "Next-gen compiler infrastructure"
  homepage "https://llvm.org/"
  url "https://github.com/llvm/llvm-project/releases/download/llvmorg-20.1.0/llvm-20.1.0.src.tar.xz"
  sha256 "9e9a1e50a5f3e0c94f0fe5f43c0e8a8d5d0b2f6a4c3e8d1b5a7f9e2c4d6a8b0c2"
  license "Apache-2.0" => { with: "LLVM-exception" }

  depends_on "cmake" => :build
  depends_on "ninja" => :build
  depends_on "python@3.14" => :build
  depends_on "swig" => :build
  depends_on "libffi"
  depends_on "libxml2"
  depends_on "ncurses"
  depends_on "zlib-ng-compat"
  depends_on "zstd"

  uses_from_macos "libedit"
  uses_from_macos "libxcrypt"

  def install
    cpu = Hardware::CPU.loongarch? ? "LoongArch64" : "X86"
    
    args = %W[
      -DLLVM_ENABLE_PROJECTS=clang;clang-tools-extra;lld;lldb;mlir;polly
      -DLLVM_ENABLE_RUNTIMES=compiler-rt;libcxx;libcxxabi;libunwind;openmp
      -DLLVM_TARGETS_TO_BUILD=#{cpu};AArch64;ARM;X86;RISCV
      -DLLVM_ENABLE_ZLIB=ON
      -DLLVM_ENABLE_ZSTD=ON
      -DLLVM_ENABLE_LIBXML2=ON
      -DLLVM_ENABLE_FFI=ON
      -DLLVM_ENABLE_RTTI=ON
      -DLLVM_INSTALL_UTILS=ON
      -DLLVM_OPTIMIZED_TABLEGEN=ON
      -DLLDB_USE_SYSTEM_SIX=ON
      -DLLVM_ENABLE_BINDINGS=OFF
      -DCMAKE_INSTALL_PREFIX=#{prefix}
    ]

    system "cmake", "-S", ".", "-B", "build", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system bin/"llvm-config", "--version"
  end
end
