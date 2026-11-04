class Cgl < Formula
  desc "Cut Generation Library"
  homepage "https://github.com/coin-or/Cgl"
  url "https://github.com/coin-or/Cgl/archive/refs/tags/releases/0.60.10.tar.gz"
  sha256 "41b7ac9402db883d9c487eb7101e59eb513cefd726e6e7a669dc94664d9385e6"
  license "EPL-2.0"
  compatibility_version 1

  livecheck do
    url :stable
    regex(%r{^releases/v?(\d+(?:\.\d+)+)$}i)
  end


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "128b97bf338b6f484a4746403736cf052d0aa259613c56c179bf04d2eee5cbc4"
  end

  depends_on "pkgconf" => [:build, :test]

  depends_on "clp"
  depends_on "coinutils"
  depends_on "osi"

  on_macos do
    depends_on "openblas"
  end

  resource "homebrew-coin-or-tools-data-sample-p0033-mps", :test do
    url "https://raw.githubusercontent.com/coin-or-tools/Data-Sample/releases/1.2.12/p0033.mps"
    sha256 "8ccff819023237c79ef32e238a5da9348725ce9a4425d48888baf3a0b3b42628"
  end

  deny_network_access!

  def install
    system "./configure", "--disable-silent-rules", "--includedir=#{include}/cgl", *std_configure_args
    system "make", "install"

    pkgshare.install "Cgl/examples"
  end

  test do
    resource("homebrew-coin-or-tools-data-sample-p0033-mps").stage testpath
    cp pkgshare/"examples/cgl1.cpp", testpath

    pkg_config_flags = shell_output("pkg-config --cflags --libs cgl").chomp.split
    system ENV.cxx, "-std=c++11", "cgl1.cpp", *pkg_config_flags, "-o", "test"
    output = shell_output("./test p0033 min")
    assert_match "Cut generation phase completed", output
  end
end
