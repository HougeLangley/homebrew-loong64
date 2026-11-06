class MecabIpadic < Formula
  desc "IPA dictionary compiled for MeCab"
  homepage "https://taku910.github.io/mecab/"
  # Canonical url is https://drive.google.com/uc?export=download&id=0B4y35FiV1wh7MWVlSDBCSXZMTXM
  url "https://deb.debian.org/debian/pool/main/m/mecab-ipadic/mecab-ipadic_2.7.0-20070801+main.orig.tar.gz"
  version "2.7.0-20070801"
  sha256 "b62f527d881c504576baed9c6ef6561554658b175ce6ae0096a60307e49e3523"
  license "NAIST-2003"

  # We check the Debian index page because the first-party website uses a Google
  # Drive download URL and doesn't list the version in any other way, so we
  # can't identify the newest version there.
  livecheck do
    url "https://deb.debian.org/debian/pool/main/m/mecab-ipadic/"
    regex(/href=.*?mecab-ipadic[._-]v?(\d+(?:\.\d+)+(?:-\d+)?)(?:\+main)?\.orig\.t/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "da41c201fa44e169bbfe1fb1661f94843bdde1acfc8d7fa8d4e74256bd397fc5"
  end

  depends_on "mecab"

  link_overwrite "lib/mecab/dic"

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    args = %W[
      --disable-debug
      --disable-dependency-tracking
      --prefix=#{prefix}
      --with-charset=utf8
      --with-dicdir=#{lib}/mecab/dic/ipadic
    ]

    system "./configure", "--build=loongarch64-unknown-linux-gnu", *args
    system "make", "install"
  end

  def caveats
    <<~EOS
      To enable mecab-ipadic dictionary, add to #{HOMEBREW_PREFIX}/etc/mecabrc:
        dicdir = #{HOMEBREW_PREFIX}/lib/mecab/dic/ipadic
    EOS
  end

  test do
    (testpath/"mecabrc").write <<~EOS
      dicdir = #{HOMEBREW_PREFIX}/lib/mecab/dic/ipadic
    EOS

    assert_match "名詞", pipe_output("mecab --rcfile=#{testpath}/mecabrc", "すもももももももものうち\n", 0)
    assert_match "名詞,固有名詞,組織", pipe_output("mecab --rcfile=#{testpath}/mecabrc", "A\n")
  end
end
