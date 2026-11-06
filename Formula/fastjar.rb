class Fastjar < Formula
  desc "Implementation of Sun's jar tool"
  homepage "https://savannah.nongnu.org/projects/fastjar"
  url "https://download.savannah.nongnu.org/releases/fastjar/fastjar-0.98.tar.gz"
  sha256 "f156abc5de8658f22ee8f08d7a72c88f9409ebd8c7933e9466b0842afeb2f145"
  license "GPL-2.0-or-later"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "9f085c1920cf69f399d434c1b7af1473de0cf219af413ed19d835d78ad70f804"
  end

  livecheck do
    url "https://download.savannah.nongnu.org/releases/fastjar/"
    regex(/href=.*?fastjar[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  on_linux do
    depends_on "zlib-ng-compat"
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    args = []
    # Help old config scripts identify arm64 linux
    args << "--build=aarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arm64?
    args << "--build=loongarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arch == :loongarch64

    system "./configure", *args, *std_configure_args
    system "make", "install"
  end

  test do
    system bin/"fastjar", "-V"
    system bin/"grepjar", "-V"
  end
end
