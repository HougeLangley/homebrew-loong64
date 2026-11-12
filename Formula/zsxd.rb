class Zsxd < Formula
  desc "Zelda Mystery of Solarus XD"
  homepage "https://www.solarus-games.org/games/the-legend-of-zelda-mystery-of-solarus-xd/"
  url "https://gitlab.com/solarus-games/games/zsxd/-/archive/v1.12.2/zsxd-v1.12.2.tar.bz2"
  sha256 "656ac2033db2aca7ad0cd5c7abb25d88509b312b155ab83546c90abbc8583df1"
  license all_of: ["CC-BY-SA-4.0", "GPL-3.0-only"]
  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "2d85116213e6a279e6587b50c25c8a6c0ef7fe687589492d6539c77d799bd5e2"
  end

  head "https://gitlab.com/solarus-games/games/zsxd.git", branch: "dev"



  depends_on "cmake" => :build
  depends_on "solarus"

  uses_from_macos "zip" => :build
  uses_from_macos "unzip" => :test

  deny_network_access!

  def install
    system "cmake", "-S", ".", "-B", "build",
                    "-DCMAKE_POLICY_VERSION_MINIMUM=3.5",
                    "-DSOLARUS_INSTALL_DATADIR=#{share}",
                    *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system formula_opt_bin("solarus")/"solarus-run", "-help"
    system "unzip", pkgshare/"data.solarus"
  end
end
