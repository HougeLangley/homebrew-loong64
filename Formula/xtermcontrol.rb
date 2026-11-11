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


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "ad1456f8b2d3440752d4c52ef6316c127470a148c35c9ecb541a361905f8e1f9"
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
    # brew test has no controlling TTY. Upstream CI reaches the terminal-query
    # path ("unsupported or disallowed"); on this host the earlier, equally
    # deterministic failure is "failed to get controlling terminal" with the
    # same exit status. Accept either no-TTY outcome.
    output = shell_output("#{bin}/xtermcontrol --force --get-fg 2>&1", 1)
    assert_match(/unsupported or disallowed|failed to get controlling terminal/, output)
  end
end
