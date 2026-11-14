class Fprobe < Formula
  desc "Libpcap-based NetFlow probe"
  homepage "https://sourceforge.net/projects/fprobe/"
  url "https://downloads.sourceforge.net/project/fprobe/fprobe/1.1/fprobe-1.1.tar.bz2"
  sha256 "3a1cedf5e7b0d36c648aa90914fa71a158c6743ecf74a38f4850afbac57d22a0"
  license "GPL-2.0-only"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "03579239b721571d858469190c156963d0da01c1545af138d9c7ce5dbee0767d"
  end

  uses_from_macos "libpcap"

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

    system "./configure", "--disable-silent-rules", "--mandir=#{man}", *args, *std_configure_args
    system "make", "install"
  end

  test do
    assert_match "NetFlow", shell_output("#{sbin}/fprobe -h").strip
  end
end
