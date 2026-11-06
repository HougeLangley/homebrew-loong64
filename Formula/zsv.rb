class Zsv < Formula
  desc "Tabular data swiss-army knife CLI"
  homepage "https://github.com/liquidaty/zsv"
  url "https://github.com/liquidaty/zsv/archive/refs/tags/v1.4.4.tar.gz"
  sha256 "99486b6901d6b576bf15afceb0bcc888ceeb3f555a6d489547eefe67eff52079"
  license "MIT"
  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "7aaaa2d8692313eb91deb719f83d3ac2d062af404f1b335055848fb9a358d4f3"
  end

  head "https://github.com/liquidaty/zsv.git", branch: "main"



  depends_on "jq"
  depends_on "pcre2"

  uses_from_macos "ncurses"

  deny_network_access!

  def install
    rm(Dir["app/external/{jq,pcre}*"])

    args = %W[
      --jq-prefix=#{formula_opt_prefix("jq")}
      --pcre2-8-prefix=#{formula_opt_prefix("pcre2")}
      --ncurses-dynamic
    ]

    system "./configure", *args, *std_configure_args
    system "make", "install", "VERSION=#{version}", "PCRE2_STATIC="
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/zsv version")

    input = <<~CSV
      a,b,c
      1,2,3
    CSV
    assert_equal "1", pipe_output("#{bin}/zsv count", input).strip
  end
end
