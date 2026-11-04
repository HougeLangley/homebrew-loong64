class Physfs < Formula
  desc "Library to provide abstract access to various archives"
  homepage "https://icculus.org/physfs/"
  url "https://github.com/icculus/physfs/archive/refs/tags/release-3.2.0.tar.gz"
  sha256 "1991500eaeb8d5325e3a8361847ff3bf8e03ec89252b7915e1f25b3f8ab5d560"
  license "Zlib"
  head "https://github.com/icculus/physfs.git", branch: "main"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "f378a6b807e2ab6280b2ea5caa93ab4d800b7f7e9fe40274a42c5c5902f281cc"
  end

  depends_on "cmake" => :build

  uses_from_macos "zip" => :test

  on_linux do
    depends_on "readline"
  end

  deny_network_access!

  def install
    # Workaround for CMake 4.0+. Remove on next release.
    if build.stable?
      odie "Remove CMake 4 workaround!" if version > "3.2.0"
      inreplace "CMakeLists.txt", "cmake_minimum_required(VERSION 3.0)",
                                  "cmake_minimum_required(VERSION 3.10)"
    end

    system "cmake", "-S", ".", "-B", "build",
                    "-DPHYSFS_BUILD_TEST=TRUE",
                    "-DCMAKE_EXE_LINKER_FLAGS=-Wl,-rpath,#{rpath}",
                    *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"test.txt").write "homebrew"
    system "zip", "test.zip", "test.txt"
    test = <<~EOS
      addarchive test.zip 1
      cat test.txt
    EOS
    output = pipe_output("#{bin}/test_physfs 2>&1", test, 0)
    expected = if OS.mac?
      "Successful.\nhomebrew"
    else
      "Successful.\n> cat test.txt\nhomebrew"
    end
    assert_match expected, output
  end
end
