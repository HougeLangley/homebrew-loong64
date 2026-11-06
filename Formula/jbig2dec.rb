class Jbig2dec < Formula
  desc "JBIG2 decoder and library (for monochrome documents)"
  homepage "https://github.com/ArtifexSoftware/jbig2dec"
  url "https://github.com/ArtifexSoftware/jbig2dec/releases/download/0.20/jbig2dec-0.20.tar.gz"
  sha256 "7b63ff6470289547e7a3a0f145cb8ea6c2afffdd65645b7d87d3b7febc96fb3a"
  license "AGPL-3.0-or-later"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "3f29a6ec0c404bfc2819e572a64275f2b22ecd1ba8ca86432011dceac3a30041"
  end


  resource "homebrew-test", :test do
    url "https://github.com/apache/tika/raw/master/tika-parsers/src/test/resources/test-documents/testJBIG2.jb2"
    sha256 "40764aed6c185f1f82123f9e09de8e4d61120e35d2b5c6ede082123749c22d91"
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    args = %W[
      --disable-dependency-tracking
      --prefix=#{prefix}
      --disable-silent-rules
      --without-libpng
    ]

    system "./configure", "--build=loongarch64-unknown-linux-gnu", *args
    system "make", "install"
  end

  test do
    resource("homebrew-test").stage testpath
    output = shell_output("#{bin}/jbig2dec -t pbm --hash testJBIG2.jb2")
    assert_match "aa35470724c946c7e953ddd49ff5aab9f8289aaf", output
    assert_path_exists testpath/"testJBIG2.pbm"
  end
end
