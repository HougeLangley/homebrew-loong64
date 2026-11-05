class TmuxMemCpuLoad < Formula
  desc "CPU, RAM memory, and load monitor for use with tmux"
  homepage "https://github.com/thewtex/tmux-mem-cpu-load"
  url "https://github.com/thewtex/tmux-mem-cpu-load/archive/refs/tags/v3.8.3.tar.gz"
  sha256 "ea7a24802d6d1223831f749e68ef29c07c9c5e45dff570022f844ce37eb56c85"
  license "Apache-2.0"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "a08c5624d5f332870d6dbe8aa5e8c0a5fe7e3139f4c5b6ff9e3638f4f6d4a548"
  end

  head "https://github.com/thewtex/tmux-mem-cpu-load.git", branch: "master"



  depends_on "cmake" => :build

  deny_network_access!

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system bin/"tmux-mem-cpu-load"
  end
end
