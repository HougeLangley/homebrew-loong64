class Zsdx < Formula
  desc "Zelda Mystery of Solarus DX"
  homepage "https://www.solarus-games.org/games/the-legend-of-zelda-mystery-of-solarus-dx"
  url "https://gitlab.com/solarus-games/games/zsdx/-/archive/v1.12.3/zsdx-v1.12.3.tar.bz2"
  sha256 "29065d3280ec03176e8de0a7a26504421d43c5778b566e50c212deb25b45d66a"
  license all_of: ["CC-BY-SA-4.0", "GPL-3.0-only"]
  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "e329eb671b016742424ec469863323ccd6827d5ff8fbc1212d3fd3d587ff3dbd"
  end

  head "https://gitlab.com/solarus-games/games/zsdx.git", branch: "dev"



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
