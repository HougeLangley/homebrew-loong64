class Lsyncd < Formula
  desc "Synchronize local directories with remote targets"
  homepage "https://github.com/lsyncd/lsyncd"
  url "https://github.com/lsyncd/lsyncd/archive/refs/tags/release-2.3.1.tar.gz"
  sha256 "fc19a77b2258dc6dbb16a74f023de7cd62451c26984cedbec63e20ff22bcbdd8"
  license "GPL-2.0-or-later"
  revision 1


  # https://github.com/lsyncd/lsyncd/issues/739
  # https://github.com/lsyncd/lsyncd/commit/724f077864989b3a2d401be3f73880175236e88b
  deprecate! date: "2026-05-17", because: :unmaintained
  disable! date: "2027-05-17", because: :unmaintained

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "92b6869cf8f25037ecbb6f5ce2678538c81d7408d63fb209754f16f165f039af"
  end

  depends_on "cmake" => :build
  depends_on "lua@5.4"

  resource "xnu" do
    # From https://opensource.apple.com/releases/
    on_tahoe :or_newer do # 26.4
      url "https://github.com/apple-oss-distributions/xnu/archive/refs/tags/xnu-12377.101.15.tar.gz"
      sha256 "4dbb9c7538107c0411c2d6bf9ef16af3fd465af36fab031f53e4f53329a42723"
    end
    on_sequoia do # 15.6
      url "https://github.com/apple-oss-distributions/xnu/archive/refs/tags/xnu-11417.140.69.tar.gz"
      sha256 "6ec42735d647976a429331cdc73a35e8f3889b56c251397c05989a59063dc251"
    end
    on_sonoma do # 14.6
      url "https://github.com/apple-oss-distributions/xnu/archive/refs/tags/xnu-10063.141.1.tar.gz"
      sha256 "ffdc143cbf4c57dac48e7ad6367ab492c6c4180e5698cb2d68e87eaf1781bc48"
    end

    # No longer maintained macOS versions so should not need updates
    on_ventura do
      url "https://github.com/apple-oss-distributions/xnu/archive/refs/tags/xnu-8796.141.3.tar.gz"
      sha256 "f08bfe045a1fb552a6cbf7450feae6a35dd003e9979edf71ea77d1a836c8dc99"
    end
    on_monterey do
      url "https://github.com/apple-oss-distributions/xnu/archive/refs/tags/xnu-8020.140.41.tar.gz"
      sha256 "b11e05d6529806aa6ec046ae462d997dfb36a26df6c0eb0452d7a67cc08ad9e7"
    end
    on_big_sur do
      url "https://github.com/apple-oss-distributions/xnu/archive/refs/tags/xnu-7195.141.2.tar.gz"
      sha256 "ec5aa94ebbe09afa6a62d8beb8d15e4e9dd8eb0a7e7e82c8b8cf9ca427004b6d"
    end
  end

  def install
    args = ["-DCMAKE_INSTALL_MANDIR=#{man}"]
    if OS.mac?
      resource("xnu").stage buildpath/"xnu"
      args += %W[-DWITH_INOTIFY=OFF -DWITH_FSEVENTS=ON -DXNU_DIR=#{buildpath}/xnu]
    else
      args += %w[-DWITH_INOTIFY=ON -DWITH_FSEVENTS=OFF]
    end
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args, *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system bin/"lsyncd", "--version"
  end
end
