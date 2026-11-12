class Bvi < Formula
  desc "Vi-like binary file (hex) editor"
  homepage "https://bvi.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/bvi/bvi/1.5.0/bvi-1.5.0.src.tar.gz"
  sha256 "6540716a1a3b2b9711635108da14b26baea488881d4a682121c0bddbba6b74cb"
  license "GPL-3.0-or-later"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "128634704eee96ad6564e9b62ac54e63c0a8f571a14d772851e25044c06f8357"
  end

  uses_from_macos "ncurses"

  deny_network_access!

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}", "dist/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--prefix=#{prefix}", "--mandir=#{man}"
    system "make", "install"
  end

  test do
    if OS.linux? && ENV["HOMEBREW_GITHUB_ACTIONS"]
      out = shell_output("#{bin}/bvi -c q", 1)
      assert_match out, "Input is not from a terminal"
    else
      system bin/"bvi", "-c", "q"
    end
  end
end
