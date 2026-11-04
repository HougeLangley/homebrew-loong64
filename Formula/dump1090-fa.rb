class Dump1090Fa < Formula
  desc "FlightAware ADS-B Ground Station System for SDRs"
  homepage "https://github.com/flightaware/dump1090"
  url "https://github.com/flightaware/dump1090/archive/refs/tags/v11.1.tar.gz"
  sha256 "21fe1164d9b189274f6837bfffad7a1fe1b3471187ade4b5dc0409c1e640143f"
  license "GPL-2.0-or-later"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "8580f9d79375ee9ce8be03df2873b7dbbcdb682c728861ee0f3057c160fdd68e"
  end

  depends_on "pkgconf" => :build
  depends_on "libbladerf"
  depends_on "librtlsdr"
  depends_on "ncurses"

  allow_network_access! :test

  def install
    system "make", "DUMP1090_VERSION=#{version}"
    bin.install "dump1090"
    bin.install "view1090"
  end

  test do
    output_log = testpath/"output.log"
    port = free_port
    pid = spawn bin/"dump1090", "--device-type", "none", "--net-ri-port", port.to_s, [:out, :err] => output_log.to_s
    begin
      sleep 5
      TCPSocket.open("localhost", port) { |sock| sock.puts "*8D3C5EE69901BD9540078D37335F;" }
      sleep 5
      assert_match "Groundspeed:   475.1 kt", output_log.read
    ensure
      Process.kill "TERM", pid
      Process.wait pid
    end
  end
end
