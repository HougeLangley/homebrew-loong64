class Xmlto < Formula
  desc "Convert XML to another format (based on XSL or other tools)"
  homepage "https://codeberg.org/xmlto/xmlto"
  url "https://codeberg.org/xmlto/xmlto/archive/0.0.29.tar.gz"
  sha256 "ccf0657f71f874d01a28729e7c08ea468ae705e087a4e12d1dcacb6b54a5d25d"
  license "GPL-2.0-or-later"

  livecheck do
    url "https://codeberg.org/xmlto/xmlto.git"
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "8b4154baae108137b175e910b0df268ceb83e820348f2b821e24b0f23df2ea1b"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build

  depends_on "docbook"
  depends_on "docbook-xsl"

  uses_from_macos "libxslt"

  on_macos do
    # Doesn't strictly depend on GNU getopt, but macOS system getopt(1)
    # does not support longopts in the optstring, so use GNU getopt.
    depends_on "gnu-getopt"
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    # GNU getopt is keg-only, so point configure to it
    ENV["GETOPT"] = formula_opt_bin("gnu-getopt")/"getopt" if OS.mac?
    # Find our docbook catalog
    ENV["XML_CATALOG_FILES"] = "#{etc}/xml/catalog"

    ENV.deparallelize
    system "autoreconf", "--force", "--install", "--verbose"
    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-silent-rules", *std_configure_args
    system "make", "install"
  end

  test do
    (testpath/"test").write <<~EOS
      <?xmlif if foo='bar'?>
      Passing test.
      <?xmlif fi?>
    EOS
    assert_equal "Passing test.", pipe_output("#{bin}/xmlif foo=bar", (testpath/"test").read).strip
  end
end
