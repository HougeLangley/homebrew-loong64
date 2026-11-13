class Gammu < Formula
  desc "Command-line utility to control a phone"
  homepage "https://wammu.eu/gammu/"
  url "https://github.com/gammu/gammu/releases/download/1.45.1/Gammu-1.45.1.tar.gz"
  sha256 "09c32e0573db6c26b23c185ce0e5600677bd57bf98cf7ec69557e24a5cad7c40"
  license "GPL-2.0-or-later"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "0b8be31207ca0378f92aba9dd99b2a6aed6c9c2ceadf02cc8f6f64411448893f"
  end

  head "https://github.com/gammu/gammu.git", branch: "master"


  depends_on "cmake" => :build

  depends_on "glib"
  depends_on "libusb"

  on_macos do
    depends_on "gettext"
  end

  def install
    args = %W[
      -DBASH_COMPLETION_COMPLETIONSDIR=#{bash_completion}
      -DCMAKE_INSTALL_RPATH=#{rpath}
      -DWITH_Postgres=OFF
      -DWITH_USB=ON
    ]
    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system bin/"gammu", "--help"
  end
end
