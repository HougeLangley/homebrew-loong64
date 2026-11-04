class Bitwuzla < Formula
  desc "SMT solver for bit-vectors, floating-points, arrays and uninterpreted functions"
  homepage "https://bitwuzla.github.io"
  url "https://github.com/bitwuzla/bitwuzla/archive/refs/tags/0.9.1.tar.gz"
  sha256 "42707f38900a20bb18108e426ba667560d1fd2ccce0d4f75aa60439b546488b4"
  license "MIT"

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "206be9accf31120132236c01a5f3e62d751dbf44587085f32c5b2871b64524e7"
  end

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end



  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkgconf" => :build
  depends_on "gmp"
  depends_on "mpfr"

  deny_network_access!

  def fetch
    system "meson", "subprojects", "download", "cadical", "symfpu"
  end

  def install
    # Not compatible with brew cadical (>= 3)
    args = %w[
      --force-fallback-for=cadical,symfpu
      -Dcadical:default_library=static
      -Ddefault_library=shared
      -Dtesting=disabled
    ]
    system "meson", "setup", "build", *args, *std_meson_args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"
  end

  test do
    (testpath/"test.btor").write <<~EOS
      (set-logic BV)
      (declare-fun x () (_ BitVec 4))
      (declare-fun y () (_ BitVec 4))
      (assert (= (bvadd x y) (_ bv6 4)))
      (check-sat)
      (get-value (x y))
    EOS
    assert_match "sat", shell_output("#{bin}/bitwuzla test.btor 2>/dev/null", 1)
  end
end
