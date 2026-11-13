class CpuFeatures < Formula
  desc "Cross platform C99 library to get cpu features at runtime"
  homepage "https://github.com/google/cpu_features"
  url "https://github.com/google/cpu_features/archive/refs/tags/v0.11.0.tar.gz"
  sha256 "ab2463f2d38fcaff1ce806be8e4c91333449931f5e02009d543b2569a3fa471a"
  license "Apache-2.0"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "f3386f2a2aa222a2978d4e7b70dc5dab92b1ceab534fb8726d0575b17e34f180"
  end

  head "https://github.com/google/cpu_features.git", branch: "main"


  depends_on "cmake" => :build

  deny_network_access!

  def install
    system "cmake", "-S", ".", "-B", "build",
                    "-DBUILD_SHARED_LIBS=ON",
                    "-DCMAKE_INSTALL_RPATH=#{rpath}",
                    *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"

    # Install static lib too
    system "cmake", "-S", ".", "-B", "build/static", *std_cmake_args
    system "cmake", "--build", "build/static"
    lib.install "build/static/libcpu_features.a"
  end

  test do
    output = shell_output(bin/"list_cpu_features")
    assert_match(/^arch\s*:/, output)
    if Hardware::CPU.arm?
      assert_match(/^implementer\s*:/, output)
      assert_match(/^variant\s*:/, output)
      assert_match(/^part\s*:/, output)
      assert_match(/^revision\s*:/, output)
    elsif Hardware::CPU.arch == :loongarch64
      # LoongArch reports arch and feature flags, not x86 brand/family fields.
      assert_match(/^arch\s+:\s+loongarch$/, output)
    else
      assert_match(/^brand\s*:/, output)
      assert_match(/^family\s*:/, output)
      assert_match(/^model\s*:/, output)
      assert_match(/^stepping\s*:/, output)
      assert_match(/^uarch\s*:/, output)
    end
    assert_match(/^flags\s*:/, output)
  end
end
