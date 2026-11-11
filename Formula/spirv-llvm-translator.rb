class SpirvLlvmTranslator < Formula
  desc "Tool and a library for bi-directional translation between SPIR-V and LLVM IR"
  homepage "https://github.com/KhronosGroup/SPIRV-LLVM-Translator"
  url "https://github.com/KhronosGroup/SPIRV-LLVM-Translator/archive/refs/tags/v22.1.7.tar.gz"
  sha256 "2b46118831851f1d43eaf20f05ae9cec4088a666e169d9fe4762b9b21826842b"
  license "Apache-2.0" => { with: "LLVM-exception" }
  compatibility_version 2

  # Our llvm formula is pinned at 22.x; upstream core's unversioned `llvm`
  # dep resolves to our 22.1.8 while the 23.x source requires LLVM 23
  # (CMake "version found is not compatible"). Pin the matching v22 series.
  # v22.1.8 references Op/Capability SubgroupBitcastShuffleINTEL which our
  # spirv-headers 1.4.363 tarball does not ship (verified upstream: 0 intel
  # extinst files); v22.1.7 is the newest tag without that reference.


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "3ef750ac1988b43e55bb89e53f248c858fcc18c7c2a1aba4e9157c526711cc33"
  end

  depends_on "cmake" => :build
  depends_on "pkgconf" => :build
  depends_on "spirv-headers" => :build
  depends_on "llvm"

  def llvm
    deps.map(&:to_formula).find { |f| f.name.match?(/^llvm(@\d+)?$/) }
  end

  def install
    ENV.append "LDFLAGS", "-Wl,-rpath,#{rpath(target: llvm.opt_lib)}" if OS.linux?
    system "cmake", "-S", ".", "-B", "build",
                    "-DBUILD_SHARED_LIBS=ON",
                    "-DCCACHE_ALLOWED=OFF",
                    "-DCMAKE_INSTALL_RPATH=#{rpath}",
                    "-DLLVM_BUILD_TOOLS=ON",
                    "-DLLVM_EXTERNAL_SPIRV_HEADERS_SOURCE_DIR=#{formula_opt_prefix("spirv-headers")}",
                    *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"test.ll").write <<~LLVM
      target datalayout = "e-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
      target triple = "spir64-unknown-unknown"

      define spir_kernel void @foo() {
        ret void
      }
    LLVM
    system llvm.opt_bin/"llvm-as", "test.ll"
    system bin/"llvm-spirv", "test.bc"
    assert_path_exists testpath/"test.spv"
  end
end
