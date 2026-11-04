class MariadbConnectorOdbc < Formula
  desc "Database driver using the industry standard ODBC API"
  homepage "https://mariadb.org/download/?tab=connector&prod=connector-odbc"
  url "https://archive.mariadb.org/connector-odbc-3.2.10/mariadb-connector-odbc-3.2.10-src.tar.gz"
  mirror "https://fossies.org/linux/misc/mariadb-connector-odbc-3.2.10-src.tar.gz/"
  sha256 "ee8b3472f9d7c19b50458893a958556a38f3d7900f91f97012a59bc2ab6f8869"
  license "LGPL-2.1-or-later"

  livecheck do
    url "https://downloads.mariadb.org/rest-api/connector-odbc/all-releases/?olderReleases=false"
    strategy :json do |json|
      json["releases"]&.map do |release|
        next if release["status"] != "stable"

        release["release_number"]
      end
    end
  end


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "e9352f87ac1b2563c236c1bb47a2fdd9ec2478c4feaa2c018631cd85fae77851"
  end

  depends_on "cmake" => :build
  depends_on "mariadb-connector-c"
  depends_on "unixodbc"

  deny_network_access!

  def install
    ENV.append_to_cflags "-I#{formula_opt_include("mariadb-connector-c")}/mariadb"
    args = %w[
      -DMARIADB_LINK_DYNAMIC=ON
      -DWITH_IODBC=OFF
      -DWITH_SSL=OPENSSL
    ]

    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args

    # By default, the installer pkg is built - we don't want that.
    # maodbc limits the build to just the connector itself.
    # install/fast prevents an "all" build being invoked that a regular "install" would do.
    system "cmake", "--build", "build", "--target", "maodbc"
    system "cmake", "--build", "build", "--target", "install/fast"
  end

  test do
    output = shell_output("#{formula_opt_bin("unixodbc")}/dltest #{lib}/mariadb/#{shared_library("libmaodbc")}")
    assert_equal "SUCCESS: Loaded #{lib}/mariadb/#{shared_library("libmaodbc")}", output.chomp
  end
end
