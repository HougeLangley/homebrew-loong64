class StartupNotification < Formula
  desc "Reference implementation of startup notification protocol"
  homepage "https://www.freedesktop.org/wiki/Software/startup-notification/"
  url "https://www.freedesktop.org/software/startup-notification/releases/startup-notification-0.12.tar.gz"
  sha256 "3c391f7e930c583095045cd2d10eb73a64f085c7fde9d260f2652c7cb3cfbe4a"
  license "LGPL-2.0-or-later"
  revision 1


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "3fbbaf7473cced3df9ed78c0bcdd5b41959029c021fa9c4009099a5953fdc2b6"
  end

  depends_on "pkgconf" => [:build, :test]
  depends_on "libx11"
  depends_on "libxcb"
  depends_on "xcb-util"

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "buildaux/#{cf}", "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}", "dist/#{cf}"].each do |rel|
        src = "/usr/share/libtool/build-aux/#{cf}"
        dest = buildpath/rel
        if dest.exist? && File.exist?(src)
          File.chmod(0644, dest)
          cp src, dest
        end
      end
    end

    args = []
    # Help old config scripts identify arm64 linux
    args << "--build=aarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    args << "--build=loongarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arch == :loongarch64

    system "./configure", *args, *std_configure_args
    system "make", "install"
  end

  test do
    assert_match "-I#{include}", shell_output("pkgconf --cflags libstartup-notification-1.0").chomp
  end
end
