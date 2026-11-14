class Openjazz < Formula
  desc "Open source Jazz Jackrabit engine"
  homepage "https://www.alister.eu/jazz/oj/"
  license "GPL-2.0-or-later"

  stable do
    url "https://github.com/AlisterT/openjazz/archive/refs/tags/20260301.tar.gz"
    sha256 "9c117a8d9aa539c4dcb3fb5788130563a83ca1d9819e538f233721d823f7a650"
    depends_on "sdl2-compat"
  end


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "d78bd22fc363d341141f161843ffc5d6d0eeac65f06d375fafe23fe2c71702e3"
  end

  head do
    url "https://github.com/AlisterT/openjazz.git", branch: "master"
    depends_on "sdl3"
  end


  depends_on "cmake" => :build

  # From LICENSE.DOC:
  # "Epic MegaGames allows and encourages all bulletin board systems and online
  # services to distribute this game by modem as long as no files are altered
  # or removed."
  resource "shareware" do
    url "https://image.dosgamesarchive.com/games/jazz.zip"
    sha256 "ed025415c0bc5ebc3a41e7a070551bdfdfb0b65b5314241152d8bd31f87c22da"
  end

  deny_network_access!

  def install
    args = ["-DDATAPATH=#{pkgshare}"]
    if build.head?
      args << "-DSDL_VERSION=3"
    elsif version > "20260301"
      odie "Switch to SDL3!"
    end

    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"

    resource("shareware").stage do
      pkgshare.install Dir["*"]
    end
  end

  def caveats
    <<~EOS
      The shareware version of Jazz Jackrabbit has been installed.
      You can install the full version by copying the game files to:
        #{pkgshare}
    EOS
  end

  test do
    system bin/"OpenJazz", "--version"
    assert_path_exists testpath/"openjazz.log"
  end
end
