class Ohcount < Formula
  desc "Source code line counter"
  homepage "https://github.com/blackducksoftware/ohcount"
  url "https://github.com/blackducksoftware/ohcount/archive/refs/tags/4.0.0.tar.gz"
  sha256 "d71f69fd025f5bae58040988108f0d8d84f7204edda1247013cae555bfdae1b9"
  license "GPL-2.0-only"
  head "https://github.com/blackducksoftware/ohcount.git", branch: "main"


  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "455a8c4d54af8f590a5a3ee071070dd1dc2b2d9f7133d6d86deca647c7d98526"
  end

  depends_on "gperf" => :build
  depends_on "libmagic"
  depends_on "pcre2"
  depends_on "ragel"

  # Apply Debian patch to port to `pcre2`
  patch do
    url "https://deb.debian.org/debian/pool/main/o/ohcount/ohcount_4.0.0-5.debian.tar.xz"
    sha256 "740228713ed4494577f9932ec13fe4be863daba9868d0bd2ac3f082c847d6a4b"
    apply "patches/build-cflags.diff",
          "patches/pcre2.patch"
    type :unofficial
    resolves "https://github.com/blackducksoftware/ohcount/issues/93"
  end

  def install
    system "./build", "ohcount"
    bin.install "bin/ohcount"
  end

  test do
    (testpath/"test.rb").write <<~RUBY
      # comment
      puts
      puts
    RUBY
    stats = shell_output("#{bin}/ohcount -i test.rb").lines.last
    assert_equal ["ruby", "2", "1", "33.3%"], stats.split[0..3]
  end
end
