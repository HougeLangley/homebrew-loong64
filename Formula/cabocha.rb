class Cabocha < Formula
  desc "Yet Another Japanese Dependency Structure Analyzer"
  homepage "https://taku910.github.io/cabocha/"
  # Files are listed in https://drive.google.com/drive/folders/0B4y35FiV1wh7cGRCUUJHVTNJRnM
  url "https://distfiles.macports.org/cabocha/cabocha-0.69.tar.bz2"
  mirror "https://www.mirrorservice.org/sites/distfiles.macports.org/cabocha/cabocha-0.69.tar.bz2"
  sha256 "9db896d7f9d83fc3ae34908b788ae514ae19531eb89052e25f061232f6165992"
  license any_of: ["BSD-3-Clause", "LGPL-2.1-or-later"]

  livecheck do
    url :homepage
    regex(%r{>\d{4}/\d{2}/\d{2}\s+(\d+(?:\.\d+)+)<}i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "075159ac664968afa76c417990b57cd4bba9022fc05a3ca50bc3731fcce85da3"
  end

  depends_on "crf++"
  depends_on "mecab"
  depends_on "mecab-ipadic"

  deny_network_access!

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "buildaux/#{cf}", "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}", "dist/#{cf}"].each do |rel|
        src = "/usr/share/libtool/build-aux/#{cf}"
        dest = buildpath/rel
        if dest.exist? && File.exist?(src)
          File.chmod(0644, dest)
          cp src, dest
        end
      end
    end

    ENV["LIBS"] = "-liconv" if OS.mac?

    args = %w[
      --with-charset=UTF8
      --with-posset=IPA
    ]
    # Help old config scripts identify arm64 linux
    args << "--build=aarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arm64?
    args << "--build=loongarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arch == :loongarch64

    system "./configure", *args, *std_configure_args
    system "make", "install"

    # cabocha's default mecab dictionary path is not the Homebrew one; write a
    # keg-local mecabrc and point cabocharc at it so runtime and test both work.
    mecabrc = prefix/"etc/cabocha/mecabrc"
    mecabrc.dirname.mkpath
    mecabrc.write "dicdir = #{Formula["mecab-ipadic"].opt_lib}/mecab/dic/ipadic\n"
    inreplace prefix/"etc/cabocharc", "# mecabrc = somewhere/mecabrc",
              "mecabrc = #{mecabrc}"
  end

  test do
    ENV["MECABRC"] = (prefix/"etc/cabocha/mecabrc").to_s
    md5 = OS.mac? ? "md5" : "md5sum"
    result = pipe_output(md5, pipe_output(bin/"cabocha", "CaboCha はフリーソフトウェアです。", 0))
    assert_equal "a5b8293e6ebcb3246c54ecd66d6e18ee", result.chomp.split.first
  end
end
