class ZeldaRothSe < Formula
  desc "Zelda Return of the Hylian SE"
  homepage "https://www.solarus-games.org/games/the-legend-of-zelda-return-of-the-hylian-se/"
  url "https://gitlab.com/solarus-games/games/zelda-roth-se/-/archive/v1.2.1/zelda-roth-se-v1.2.1.tar.bz2"
  sha256 "1cff44fe97eab1327a0c0d11107ca10ea983a652c4780487f00f2660a6ab23c0"
  license all_of: [
    "GPL-3.0-only", # lua scripts
    "CC-BY-SA-4.0", # data files
  ]
  head "https://gitlab.com/solarus-games/games/zelda-roth-se.git", branch: "dev"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "5594732375fdf80120f4530270ec6ddaa6cf0c871413a187d19532bb9ff0ca47"
  end

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
    system "unzip", share/"zelda_roth_se/data.solarus"
  end
end
