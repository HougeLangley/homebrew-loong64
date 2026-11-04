class T2sz < Formula
  desc "Compress a file into a seekable zstd with per-file seeking for tar archives"
  homepage "https://github.com/martinellimarco/t2sz"
  url "https://github.com/martinellimarco/t2sz/archive/refs/tags/v1.2.5.tar.gz"
  sha256 "4bdc590a8a2085951cfbe83ef6ab22b5fd4723163662e1aae41260c0b5a49a01"
  license "GPL-3.0-or-later"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "4ec9e7878c4d86603acfbb8e84d076aff6de31edeabb341246bdcebca9a1bbd0"
  end

  depends_on "cmake" => :build
  depends_on "zstd"

  deny_network_access!

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/t2sz -V 2>&1")

    (testpath/"hello.txt").write "Hello, Homebrew!"
    system "tar", "cf", "test.tar", "-C", testpath, "hello.txt"
    system bin/"t2sz", "-o", "test.tar.zst", "test.tar"
    assert_path_exists testpath/"test.tar.zst"

    system "zstd", "-o", "test.restored.tar", "--decompress", "test.tar.zst"
    assert_equal (testpath/"test.tar").read, (testpath/"test.restored.tar").read
  end
end
