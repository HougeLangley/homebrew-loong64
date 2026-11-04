class Exodriver < Formula
  desc "Thin interface to LabJack devices"
  homepage "https://labjack.com/support/linux-and-mac-os-x-drivers"
  url "https://github.com/labjack/exodriver/archive/refs/tags/v2.7.0.tar.gz"
  sha256 "ef11760322b31f16802ec202406e780339f54bde774689b97e926778417d6c79"
  license "MIT"
  head "https://github.com/labjack/exodriver.git", branch: "master"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "dd5cf761360dbc09865ec9202e76d7b110c8fd6f86354ae185488238f53e9230"
  end

  depends_on "libusb"

  def install
    system "make", "-C", "liblabjackusb", "install",
           "PREFIX=#{prefix}", "RUN_LDCONFIG=0", "LINK_SO=1"
    ENV.prepend "CPPFLAGS", "-I#{include}"
    ENV.prepend "LDFLAGS", "-L#{lib}"
    system "make", "-C", "examples/Modbus"
    pkgshare.install "examples/Modbus/testModbusFunctions"
  end

  test do
    output = shell_output("#{pkgshare}/testModbusFunctions")
    assert_match(/Result:\s+writeBuffer:/, output)
  end
end
