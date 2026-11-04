class Mydumper < Formula
  desc "MySQL logical backup tool"
  homepage "https://github.com/mydumper/mydumper"
  url "https://github.com/mydumper/mydumper/archive/refs/tags/v1.0.11-1.tar.gz"
  sha256 "7de75355e0320506ebc353e110001fb30e61d44c4524ee5f9ca620dcb3474109"
  license "GPL-3.0-or-later"
  head "https://github.com/mydumper/mydumper.git", branch: "master"

  livecheck do
    url :stable
    regex(/v?(\d+(?:\.\d+)+(-\d+)?)/i)
    strategy :github_latest
  end


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "11bc7ccfc1b114328882086917b34e3ccf5eaab633ae751b0ffba32f779d061c"
  end

  depends_on "cmake" => :build
  depends_on "pkgconf" => :build
  depends_on "sphinx-doc" => :build
  depends_on "glib"
  depends_on "mariadb-connector-c"
  depends_on "pcre2"

  deny_network_access!

  def install
    ENV.append "LDFLAGS", "-Wl,-dead_strip_dylibs" if OS.mac? # avoid openssl linkage

    # Avoid installing config into /etc
    inreplace "CMakeLists.txt", "/etc", etc

    # Override location of mysql-client
    args = %W[
      -DMYSQL_CONFIG_PREFER_PATH=#{formula_opt_bin("mariadb-connector-c")}
    ]

    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    assert_match "metadata file was not found",
                 shell_output("#{bin}/myloader --directory=#{testpath} 2>&1", 1)
  end
end
