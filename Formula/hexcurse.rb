class Hexcurse < Formula
  desc "Ncurses-based console hex editor"
  homepage "https://github.com/LonnyGomes/hexcurse"
  url "https://github.com/LonnyGomes/hexcurse/archive/refs/tags/v1.60.0.tar.gz"
  sha256 "f6919e4a824ee354f003f0c42e4c4cef98a93aa7e3aa449caedd13f9a2db5530"
  license "GPL-2.0-or-later"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "ac5fb1e5b6366909461df666b5e9e3cb884d61c1cae9591a46f66d63ec0c9ff0"
  end

  uses_from_macos "ncurses"

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

    # Work around failure from GCC 10+ using default of `-fno-common`
    # multiple definition of `fpIN'; file.o:(.bss+0x0): first defined here
    ENV.append_to_cflags "-fcommon" if OS.linux?

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--mandir=#{man}", *std_configure_args
    system "make", "install"
  end

  test do
    system bin/"hexcurse", "-help"
  end
end
