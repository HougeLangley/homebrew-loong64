class Ballerburg < Formula
  desc "Castle combat game"
  homepage "https://baller.frama.io/"
  license "GPL-3.0-or-later"

  stable do
    url "https://framagit.org/baller/ballerburg/-/archive/v1.2.3/ballerburg-v1.2.3.tar.bz2"
    sha256 "2e55087c70e10a827a270493732d3928f8fb0abb6b583661f80cbbe1efac80f7"
    depends_on "sdl2-compat"
  end


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "eaad5e94deb521c6edb180f43772806465ea725bea82540850d080abb9a7955f"
  end

  head do
    url "https://framagit.org/baller/ballerburg.git", branch: "main"
    depends_on "sdl3"
  end


  depends_on "cmake" => :build

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    ENV["SDL_VIDEODRIVER"] = "dummy"
    pid = spawn bin/"ballerburg"
    sleep 3
    Process.kill "TERM", pid
    Process.wait pid
    assert_equal 0, $CHILD_STATUS.exitstatus
  end
end
