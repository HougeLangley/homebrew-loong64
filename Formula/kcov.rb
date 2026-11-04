class Kcov < Formula
  desc "Code coverage tester for compiled programs, Python, and shell scripts"
  homepage "https://simonkagstrom.github.io/kcov/"
  license "GPL-2.0-or-later"
  revision 2
  head "https://github.com/SimonKagstrom/kcov.git", branch: "master"

  stable do
    url "https://github.com/SimonKagstrom/kcov/archive/refs/tags/v43.tar.gz"
    sha256 "4cbba86af11f72de0c7514e09d59c7927ed25df7cebdad087f6d3623213b95bf"

    patch do
      url "https://github.com/SimonKagstrom/kcov/commit/698f612b01e776dfbc4bab11d320097425918423.patch?full_index=1"
      sha256 "9465fa31cde08a449e03b8b9ac6149d2ad6eb337189c348000def5eabd58d519"
      type :backport
      resolves "https://github.com/SimonKagstrom/kcov/issues/475"
    end
  end

  # We check the Git tags because, as of writing, the "latest" release on GitHub
  # is a prerelease version (`pre-v40`), so we can't rely on it being correct.
  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)*)$/i)
  end


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "bb13ac0c4929177afd613543c52af2a733100595265f23a70ff64c60bad720da"
  end

  depends_on "cmake" => :build
  depends_on "pkgconf" => :build

  depends_on "dwarfutils"
  depends_on "openssl@4"

  uses_from_macos "python" => :build
  uses_from_macos "curl"

  on_linux do
    depends_on "elfutils"
    depends_on "zlib-ng-compat"
  end

  allow_network_access! :test

  def install
    system "cmake", "-S", ".", "-B", "build", "-DSPECIFY_RPATH=ON", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"hello.bash").write <<~BASH
      #!/bin/bash
      echo "Hello, world!"
    BASH

    system bin/"kcov", testpath/"out", testpath/"hello.bash"
    assert_path_exists testpath/"out/hello.bash/coverage.json"
  end
end
