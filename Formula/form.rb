class Form < Formula
  desc "Symbolic manipulation system"
  homepage "https://www.nikhef.nl/~form/"
  url "https://github.com/form-dev/form/releases/download/v5.0.2/form-5.0.2.tar.gz"
  sha256 "90a3fbc31a31de50a181e63ce222d0224642a5916fdbb25373913558a6d6921a"
  license "GPL-3.0-or-later"

  livecheck do
    url :stable
    strategy :github_latest
  end


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "7b672c38e9f75bc63948d2088ecd430e259c6f508b3692889293f88df6568e75"
  end

  depends_on "flint"
  depends_on "gmp"
  depends_on "mpfr"
  depends_on "zstd"

  on_linux do
    depends_on "zlib-ng-compat"
  end

  def install
    system "./configure", *std_configure_args, "--disable-silent-rules", "--disable-native"
    system "make", "install"
  end

  test do
    (testpath/"test.frm").write <<~EOS
      Symbol x,n;
      Local E = x^10;

      repeat id x^n?{>1} = x^(n-1) + x^(n-2);

      Print;
      .end
    EOS

    expected_match = /E\s*=\s*34 \+ 55\*x;/
    assert_match expected_match, shell_output("#{bin}/form #{testpath}/test.frm")
    assert_match expected_match, shell_output("#{bin}/tform #{testpath}/test.frm")
  end
end
