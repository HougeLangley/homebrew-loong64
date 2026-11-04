class Lpc21isp < Formula
  desc "In-circuit programming (ISP) tool for several NXP microcontrollers"
  homepage "https://lpc21isp.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/lpc21isp/lpc21isp/1.97/lpc21isp_197.tar.gz"
  version "1.97"
  sha256 "9f7d80382e4b70bfa4200233466f29f73a36fea7dc604e32f05b9aa69ef591dc"
  license "LGPL-3.0-or-later"


  deny_network_access!

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "b72fea2ccd42f66c52a7c2123d03b037285e96837fb6a5ec01dade72d84ae439"
  end

  def install
    system "make"
    bin.install ["lpc21isp"]
  end

  test do
    (testpath/"test.hex").write <<~EOS
      :0400000001020304F2
      :00000001FF
    EOS

    # Converts the Intel hex file (dumped to debugout.bin at debug level 4),
    # then fails to open the non-existent serial port
    output = shell_output("#{bin}/lpc21isp -debug4 -hex test.hex #{testpath}/nonexistent 115200 12000 2>&1", 2)
    assert_match "Image size : 4", output
    assert_match "Can't open COM-Port #{testpath}/nonexistent !", output
    assert_equal "\x01\x02\x03\x04".b, (testpath/"debugout.bin").binread
  end
end
