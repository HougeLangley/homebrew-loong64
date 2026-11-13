class Esniper < Formula
  desc "Snipe eBay auctions from the command-line"
  homepage "https://sourceforge.net/projects/esniper/"
  url "https://downloads.sourceforge.net/project/esniper/esniper/2.35.0/esniper-2-35-0.tgz"
  version "2.35.0"
  sha256 "a93d4533e31640554f2e430ac76b43e73a50ed6d721511066020712ac8923c12"
  license "BSD-2-Clause"



  # https://sourceforge.net/p/esniper/git/ci/e2b495c6aae6596a2c8ac039d76afdf0764b06d7/
  deprecate! date: "2026-03-30", because: :unmaintained
  disable! date: "2026-09-30", because: :unmaintained

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "fec7053a37f0c7f43475d0bac02aff99f9b14ee65343c4cc017d41ccd8e39352"
  end

  uses_from_macos "curl"

  deny_network_access!

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
    assert_match "Auction file \"test.auction\" is not readable", shell_output("#{bin}/esniper test.auction 2>&1", 1)
  end
end
