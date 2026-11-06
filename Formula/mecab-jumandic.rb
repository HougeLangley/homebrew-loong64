class MecabJumandic < Formula
  desc "See mecab"
  homepage "https://taku910.github.io/mecab/"
  url "https://www.mirrorservice.org/sites/distfiles.macports.org/mecab/mecab-jumandic-7.0-20130310.tar.gz"
  mirror "https://mirrors.ustc.edu.cn/macports/distfiles/mecab/mecab-jumandic-7.0-20130310.tar.gz"
  sha256 "eaf216758edee9a159bc3d02507007318686b9537943268c4565cc1f9ef07f15"
  license "BSD-3-Clause"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "ed20aaa8489df509996efae3c9ac37f25524109d7d5cfb84073b16bd0cf1ea40"
  end

  livecheck do
    skip "No longer developed or maintained"
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
      --with-dicdir=#{lib}/mecab/dic/jumandic
    ]

    system "./configure", "--build=loongarch64-unknown-linux-gnu", *args
    system "make", "install"
  end

  def caveats
    <<~EOS
      To enable mecab-jumandic dictionary, add to #{HOMEBREW_PREFIX}/etc/mecabrc:
        dicdir = #{HOMEBREW_PREFIX}/lib/mecab/dic/jumandic
    EOS
  end

  test do
    (testpath/"mecabrc").write <<~EOS
      dicdir = #{HOMEBREW_PREFIX}/lib/mecab/dic/jumandic
    EOS

    pipe_output("mecab --rcfile=#{testpath}/mecabrc", "すもももももももものうち\n", 0)
  end
end
