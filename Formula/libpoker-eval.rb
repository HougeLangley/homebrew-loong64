class LibpokerEval < Formula
  desc "C library to evaluate poker hands"
  homepage "https://pokersource.sourceforge.net/"
  # http://download.gna.org/pokersource/sources/poker-eval-138.0.tar.gz is offline
  url "https://launchpad.net/ubuntu/+archive/primary/+sourcefiles/poker-eval/138.0-1/poker-eval_138.0.orig.tar.gz"
  sha256 "92659e4a90f6856ebd768bad942e9894bd70122dab56f3b23dd2c4c61bdbcf68"
  license "GPL-3.0-or-later"

  livecheck do
    skip "No longer developed or maintained"
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "035b69b05f55e86230d1d3639f09658746b8a9a3b43f099580d5cfb20b58394d"
  end

  depends_on "pkgconf" => :test

  deny_network_access!

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
    args << "--build=aarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    args << "--build=loongarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arch == :loongarch64
    args << "--build=loongarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arch == :loongarch64

    system "./configure", *args, *std_configure_args
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <poker_defs.h>
      #include <inlines/eval.h>

      int main(void) {
        char *cards[] = { "Ah", "Kh", "Qh", "Jh", "Th" };
        CardMask hand;
        int i, card;

        CardMask_RESET(hand);
        for (i = 0; i < 5; i++) {
          if (StdDeck_stringToCard(cards[i], &card) == 0) return 1;
          StdDeck_CardMask_SET(hand, card);
        }
        StdRules_HandVal_print(StdDeck_StdRules_EVAL_N(hand, 5));
        return 0;
      }
    C

    pkgconf_flags = shell_output("pkgconf --cflags --libs poker-eval").chomp.split
    system ENV.cc, "test.c", "-o", "test", *pkgconf_flags
    assert_equal "StFlush (A)", shell_output("./test").strip
  end
end
