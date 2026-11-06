class Dhcping < Formula
  desc "Perform a dhcp-request to check whether a dhcp-server is running"
  homepage "https://www.mavetju.org/unix/general.php"
  url "https://www.mavetju.org/download/dhcping-1.2.tar.gz"
  mirror "https://deb.debian.org/debian/pool/main/d/dhcping/dhcping_1.2.orig.tar.gz"
  sha256 "32ef86959b0bdce4b33d4b2b216eee7148f7de7037ced81b2116210bc7d3646a"
  license "BSD-2-Clause"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "af15020d255c54930fa22db36f0a845e6bf9cf77f4afdf28b8e44d360b430e8f"
  end

  livecheck do
    url :homepage
    regex(/href=.*?dhcping[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  allow_network_access! :test

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    args = ["--mandir=#{man}"]
    # Help old config scripts identify arm64 linux
    args << "--build=aarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arm64?
    args << "--build=loongarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arch == :loongarch64

    system "./configure", *args, *std_configure_args
    system "make", "install"
  end

  test do
    output = shell_output("#{bin}/dhcping -c 10.0.0.2 -s 10.0.0.1 -h 34:e6:d7:0f:a9:83", 1)
    assert_match "This program should only be ran by root or be installed as setuid root.", output
  end
end
