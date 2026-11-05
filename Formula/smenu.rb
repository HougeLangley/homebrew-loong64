class Smenu < Formula
  desc "Powerful and versatile CLI selection tool for interactive or scripting use"
  homepage "https://github.com/p-gen/smenu"
  url "https://github.com/p-gen/smenu/releases/download/v1.5.0/smenu-1.5.0.tar.bz2"
  sha256 "2de2217d322a5e28cb20f9128e60df6c00b4e8e8879381ac8ed8bdcdccc4c5ca"
  license "MPL-2.0"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "48a1d6293e10eaf3e8de654e77f3a53a0952465fe32c6d9fb86469f669579a67"
  end

  # Exclude release candidate tags
  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end


  uses_from_macos "ncurses"

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", *std_configure_args
    system "make", "install"
  end

  test do
    require "pty"

    PTY.spawn(bin/"smenu", "--version") do |r, _w, _pid|
      r.winsize = [80, 60]

      begin
        assert_match version.to_s, r.read
      rescue Errno::EIO
        # GNU/Linux raises EIO when read is done on closed pty
      end
    end
  end
end
