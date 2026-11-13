class Jed < Formula
  desc "Powerful editor for programmers"
  homepage "https://www.jedsoft.org/jed/"
  url "https://www.jedsoft.org/releases/jed/jed-0.99-19.tar.gz"
  mirror "https://deb.debian.org/debian/pool/main/j/jed/jed_0.99.19.orig.tar.gz"
  sha256 "5eed5fede7a95f18b33b7b32cb71be9d509c6babc1483dd5c58b1a169f2bdf52"
  license "GPL-2.0-or-later"

  livecheck do
    url "https://www.jedsoft.org/releases/jed/"
    regex(/href=.*?jed.?v?(\d+(?:\.\d+)+(?:-\d+)?)\.t/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "5a4263b0cbe81fb22b7f4e5b072527831199e2f382374e9d627191dd43e7bd6f"
  end

  head do
    url "git://git.jedsoft.org/git/jed.git", branch: "master"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
  end

  depends_on "s-lang"

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "buildaux/#{cf}", "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}", "dist/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    args = ["--with-slang=#{formula_opt_prefix("s-lang")}"]

    if build.head?
      cd "autoconf" do
        system "make"
      end
    elsif OS.linux?
      if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
        # Help old config scripts identify arm64 linux
        args << "--build=aarch64-unknown-linux-gnu"
      elsif Hardware::CPU.arch == :loongarch64
        args << "--build=loongarch64-unknown-linux-gnu"
      end
    end
    system "./configure", *args, *std_configure_args
    system "make"
    ENV.deparallelize
    system "make", "install"
  end

  test do
    (testpath/"test.sl").write "flush (\"Hello, world!\");"
    assert_equal "Hello, world!",
                 shell_output("#{bin}/jed -script test.sl").chomp
  end
end
