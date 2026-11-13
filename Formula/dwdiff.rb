class Dwdiff < Formula
  desc "Diff that operates at the word level"
  homepage "https://os.ghalkes.nl/dwdiff.html"
  url "https://os.ghalkes.nl/dist/dwdiff-2.1.4.tar.bz2"
  sha256 "df16fec44dcb467d65a4246a43628f93741996c1773e930b90c6dde22dd58e0a"
  license "GPL-3.0-only"
  revision 11

  livecheck do
    url "https://os.ghalkes.nl/dist/"
    regex(/href=.*?dwdiff[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "0572d8210e7b11fd36774947657051534cc40cf32d35e993ebdcde0009c55940"
  end

  depends_on "gettext" => :build
  depends_on "pkgconf" => :build
  depends_on "icu4c@79"

  on_macos do
    depends_on "gettext"
  end

  deny_network_access!

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}", "dist/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    if OS.mac?
      ENV.append "LDFLAGS", "-L#{formula_opt_lib("gettext")}"
      ENV.append "LDLIBS", "-lintl"
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--prefix=#{prefix}"
    system "make", "install"

    # Remove non-English man pages
    rm_r(man/"nl")
    rm_r(man/"nl.UTF-8")
    rm_r(share/"locale/nl")
  end

  test do
    (testpath/"a").write "I like beers"
    (testpath/"b").write "I like formulae"
    diff = shell_output("#{bin}/dwdiff a b", 1)
    assert_equal "I like [-beers-] {+formulae+}", diff
  end
end
