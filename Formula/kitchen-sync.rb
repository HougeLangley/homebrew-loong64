class KitchenSync < Formula
  desc "Fast efficiently sync database without dumping & reloading"
  homepage "https://github.com/willbryant/kitchen_sync"
  url "https://github.com/willbryant/kitchen_sync/archive/refs/tags/v2.21.tar.gz"
  sha256 "0a2c25001069c90135a91b1cc70c1b9096c3c6e127f6a14f1b45cdbb0c209f09"
  license "MIT"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "d6c7c2449abb4007473a4884d77cf688c8ee8676e6139700fe732a06d21d756e"
  end

  head "https://github.com/willbryant/kitchen_sync.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end


  depends_on "cmake" => :build
  depends_on "libpq"
  depends_on "mariadb-connector-c"

  deny_network_access!

  def install
    # GCC 16 no longer pulls <cstdint> transitively; bundled yaml-cpp needs it.
    ENV.append_to_cflags "-include stdint.h"
    system "cmake", "-S", ".", "-B", "build",
                    "-DMySQL_INCLUDE_DIR=#{formula_opt_include("mariadb-connector-c")}/mariadb",
                    "-DMySQL_LIBRARY_DIR=#{formula_opt_lib("mariadb-connector-c")}",
                    "-DPostgreSQL_INCLUDE_DIR=#{formula_opt_include("libpq")}",
                    "-DPostgreSQL_LIBRARY_DIR=#{formula_opt_lib("libpq")}",
                    *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    output = shell_output("#{bin}/ks --from mysql://b/ --to mysql://d/ 2>&1", 1)

    assert_match "Unknown server host", output
    assert_match "Kitchen Syncing failed.", output
  end
end
