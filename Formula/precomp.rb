class Precomp < Formula
  desc "Command-line precompressor to achieve better compression"
  homepage "http://schnaader.info/precomp.php"
  url "https://github.com/schnaader/precomp-cpp/archive/refs/tags/v0.4.7.tar.gz"
  sha256 "b4064f9a18b9885e574c274f93d73d8a4e7f2bbd9e959beaa773f2e61292fb2b"
  license "Apache-2.0"
  head "https://github.com/schnaader/precomp-cpp.git", branch: "master"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "e7742db403db4c8f0a9d41bbd302498ecffc6dce558bbbdfaeb05584c49a0afc"
  end

  depends_on "cmake" => :build

  patch do
    url "https://github.com/schnaader/precomp-cpp/commit/b6fee1f4f4f3f6076862e9d33b67692d3c0c5f19.patch?full_index=11"
    sha256 "667d37f1f0dfbbb664779b7311df5c4a5d0b2c56cfd1a50c847260c51f1c18aa"
    type :unofficial
    resolves "https://github.com/schnaader/precomp-cpp/pull/146"
  end

  deny_network_access!

  def install
    # Workaround for CMake 4 compatibility
    args = %w[-DCMAKE_POLICY_VERSION_MINIMUM=3.5]
    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    bin.install "build/precomp"
  end

  test do
    cp bin/"precomp", testpath/"precomp"
    system "gzip", "-1", testpath/"precomp"

    system bin/"precomp", testpath/"precomp.gz"
    rm testpath/"precomp.gz", force: true
    system bin/"precomp", "-r", testpath/"precomp.pcf"
    system "gzip", "-d", testpath/"precomp.gz"
  end
end
