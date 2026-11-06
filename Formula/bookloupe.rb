class Bookloupe < Formula
  desc "List common formatting errors in a Project Gutenberg candidate file"
  homepage "http://www.juiblex.co.uk/pgdp/bookloupe/"
  url "http://www.juiblex.co.uk/pgdp/bookloupe/bookloupe-2.0.tar.gz"
  sha256 "15b1f5a0fa01e7c0a0752c282f8a354d3dc9edbefc677e6e42044771d5abe3c9"
  license "GPL-2.0-only"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "5eeb5f4dddc1d6f496f00456bca8dbbb829defb3f2fea49cbf273864015e1079"
  end

  revision 1


  deprecate! date: "2026-01-05", because: "is not available via HTTPS"
  disable! date: "2027-01-05", because: "is not available via HTTPS"

  depends_on "pkgconf" => :build

  depends_on "glib"

  on_macos do
    depends_on "gettext"
  end

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

    system "./configure", "--disable-silent-rules", *args, *std_configure_args
    system "make", "install"
  end

  test do
    ENV["BOOKLOUPE"] = bin/"bookloupe"

    Dir["#{pkgshare}/*.tst"].each do |test_file|
      # Skip test that fails on macOS
      # http://project.juiblex.co.uk/bugzilla/show_bug.cgi?id=39
      # (bugzilla page is not publicly accessible)
      next if test_file.end_with?("/markup.tst")

      system bin/"loupe-test", test_file
    end
  end
end
