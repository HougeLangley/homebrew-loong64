class QuickjsNg < Formula
  desc "QuickJS, the Next Generation: a mighty JavaScript engine"
  homepage "https://quickjs-ng.github.io/quickjs/"
  url "https://github.com/quickjs-ng/quickjs/archive/refs/tags/v0.17.0.tar.gz"
  sha256 "559bc4c420475e55c7ab4510adbc562f55d7524d75e8e89d79ce4bb02f5687d9"
  license "MIT"
  head "https://github.com/quickjs-ng/quickjs.git", branch: "master"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "428182090b8b3701c25faccb8c278931957cb60b8a5b15d5984a23a35d436bf9"
  end

  depends_on "cmake" => :build

  conflicts_with "quickjs", because: "both install a `qjs` binary"

  deny_network_access!

  def install
    system "cmake", "-S", ".", "-B", "build",
      "-DBUILD_SHARED_LIBS=ON",
      "-DQJS_BUILD_LIBC=ON",
      "-DCMAKE_MACOSX_RPATH=OFF",
      *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    output = shell_output("#{bin}/qjs --eval 'const js=\"JS\"; console.log(`Q${js}${(7 + 35)}`);'")
    assert_match "QJS42", output

    test_file = testpath/"test.js"
    test_file.write "console.log('hello');"
    system bin/"qjsc", test_file
    assert_path_exists testpath/"out.c"
  end
end
