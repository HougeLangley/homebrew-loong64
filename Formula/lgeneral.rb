class Lgeneral < Formula
  desc "Turn-based strategy engine heavily inspired by Panzer General"
  homepage "https://lgames.sourceforge.io/LGeneral/"
  url "https://downloads.sourceforge.net/lgeneral/lgeneral/lgeneral-1.4.4.tar.gz"
  sha256 "0a26b495716cdcab63b49a294ba31649bc0abe74ce0df48276e52f4a6f323a95"
  license "GPL-2.0-or-later"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "04e92287889f2e63df57bef2a2b85779bfc4a97eb9ab9d1aacee4157e3e196f6"
  end

  depends_on "sdl12-compat"

  on_macos do
    depends_on "gettext"
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}", "dist/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    # Applied in community , to remove in next release
    inreplace "configure", "#include <unistd.h>", "#include <sys/stat.h>\n#include <unistd.h>"

    args = ["--disable-silent-rules", "--disable-sdltest"]
    # Help old config scripts identify arm64 linux
    args << "--build=aarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arm64?
    args << "--build=loongarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arch == :loongarch64

    system "./configure", *args, *std_configure_args
    system "make", "install"

    # Preserve all empty directories which are needed at runtime
    touch pkgshare.find.filter_map { |path| path/".keepme" if path.directory? && path.children.empty? }
  end

  def caveats
    <<~EOS
      Requires pg-data.tar.gz or the original DOS version of Panzer General. Can be downloaded from
      https://sourceforge.net/projects/lgeneral/files/lgeneral-data/pg-data.tar.gz/download
      To install use:
        lgc-pg -s <pg-data-unzipped-dir> -d #{opt_pkgshare}
      ⚠️ Note: Sound and music are not supported in this build
    EOS
  end

  test do
    assert_match "LGeneral reinforcement editor and query tool", shell_output("#{bin}/lged --help", 1)
    return if OS.mac? # cannot run lgeneral within macOS sandbox

    system bin/"lgeneral", "--version"

    pid = spawn bin/"lgeneral"
    sleep 3
    Process.kill "TERM", pid
  end
end
