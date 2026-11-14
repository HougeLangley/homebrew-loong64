class Httping < Formula
  desc "Ping-like tool for HTTP requests"
  homepage "https://github.com/folkertvanheusden/HTTPing"
  url "https://github.com/folkertvanheusden/HTTPing/archive/refs/tags/v4.4.0.tar.gz"
  sha256 "87fa2da5ac83c4a0edf4086161815a632df38e1cc230e1e8a24a8114c09da8fd"
  license "AGPL-3.0-only"
  revision 2
  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "255f966cc11ac051a0de275e499957ba85edac02b39d6d4fcdd30d828ad1a7c8"
  end

  head "https://github.com/folkertvanheusden/HTTPing.git", branch: "master"

  # There can be a notable gap between when a version is tagged and a
  # corresponding release is created, so we check the "latest" release instead
  # of the Git tags.
  livecheck do
    url :stable
    strategy :github_latest
  end



  depends_on "cmake" => :build
  depends_on "gettext" => :build # for msgfmt
  depends_on "pkgconf" => :build
  depends_on "fftw"
  depends_on "openssl@4"

  uses_from_macos "ncurses"

  on_macos do
    depends_on "gettext" # for libintl
  end

  # enable TCP Fast Open on macOS
  patch do
    url "https://github.com/folkertvanheusden/HTTPing/commit/79236affb75667cf195f87a58faaebe619e7bfd4.patch?full_index=1"
    sha256 "765fd15dcb35a33141d62b70e4888252a234b9f845c8e35059654852a0d19d1c"
    type :backport
    resolves "https://github.com/folkertvanheusden/HTTPing/pull/48"
  end

  allow_network_access! :test

  def install
    system "cmake", "-S", ".", "-B", "build",
                    "-DCMAKE_BUILD_TYPE=Release",
                    "-DUSE_SSL=ON",
                    "-DUSE_GETTEXT=ON",
                    "-DUSE_TUI=ON",
                    "-DUSE_FFTW3=ON",
                    *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    expected = /HTTPing v#{Regexp.escape(version.to_s)}.*SSL support included.*ncurses interface with FFT included/m
    assert_match expected, shell_output("#{bin}/httping --version 2>&1")

    system bin/"httping", "-c", "2", "-g", "https://brew.sh/"
  end
end
