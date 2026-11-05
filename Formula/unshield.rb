class Unshield < Formula
  desc "Extract files from InstallShield cabinet files"
  homepage "https://github.com/twogood/unshield"
  url "https://github.com/twogood/unshield/archive/refs/tags/1.6.2.tar.gz"
  sha256 "a937ef596ad94d16e7ed2c8553ad7be305798dcdcfd65ae60210b1e54ab51a2f"
  license "MIT"
  bottle do
    rebuild 3
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "6c51f48beb601c19f235fab48bccae775b647ed5141bc66dba774a47cb63dc33"
  end

  head "https://github.com/twogood/unshield.git", branch: "main"



  depends_on "cmake" => :build
  depends_on "openssl@4"

  on_linux do
    depends_on "zlib-ng-compat"
  end

  deny_network_access!

  def install
    # cmake check for libiconv will miss the OS library without this hint
    ENV.append "LDFLAGS", "-liconv" if OS.mac?

    system "cmake", "-S", ".", "-B", "build", "-DUSE_OUR_OWN_MD5=OFF", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system bin/"unshield", "-e", "sjis", "-V"
  end
end
