class MinLang < Formula
  desc "Small but practical concatenative programming language and shell"
  homepage "https://min-lang.org"
  url "https://git.sr.ht/~h3rald/min/archive/v0.48.1.tar.gz"
  sha256 "baec4d176ff138fcf39784ad97a6a9125454a8d3ccb4db3e6ea59aa2d6716a45"
  license "MIT"
  revision 1

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end



  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "d1e7b87a8ae0655bd6da9c9d276ae76850376e572dd10095660e2fabdcd9c82e"
  end

  depends_on "nim"
  depends_on "openssl@4"
  depends_on "pcre2" => :no_linkage

  def install
    # Remove bundled libraries
    rm_r(["minpkg/vendor/openssl", "minpkg/vendor/pcre"])
    inreplace ["minpkg/lib/min_crypto.nim", "minpkg/lib/min_http.nim"], /passL: "-B?static /, 'passL: "'
    inreplace "minpkg/lib/min_global.nim", /passL: "-B?static (.*) -lpcre([" ])/, "passL: \"\\1\\2"

    system "nimble", "build", "--passL:\"-lssl -lcrypto -Wl,-rpath,#{rpath(target: formula_opt_lib("pcre2"))}\""
    bin.install "min"
  end

  test do
    testfile = testpath/"test.min"
    testfile.write <<~EOS
      sys.pwd sys.ls (fs.type "file" ==) filter '> sort
      puts!
    EOS
    assert_match testfile.to_s, shell_output("#{bin}/min test.min")
  end
end
