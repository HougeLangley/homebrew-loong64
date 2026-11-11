class Xtermcontrol < Formula
  desc "Control xterm properties such as colors, title, font and geometry"
  homepage "https://thrysoee.dk/xtermcontrol/"
  url "https://thrysoee.dk/xtermcontrol/xtermcontrol-3.11.tar.gz"
  sha256 "49ea6d3eda0dbcf875363763cefe1818ce6786b9910255ea641d9786bdafd44c"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?xtermcontrol[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end



  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}", "dist/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", *std_configure_args
    system "make", "install"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/xtermcontrol --version")
    expected = "--get-fg is unsupported or disallowed by this terminal"
    assert_match expected, shell_output("#{bin}/xtermcontrol --force --get-fg 2>&1", 1)
  end
end
