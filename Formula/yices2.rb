class Yices2 < Formula
  desc "Yices SMT Solver"
  homepage "https://yices.csl.sri.com/"
  url "https://github.com/SRI-CSL/yices2/archive/refs/tags/yices-2.7.0.tar.gz"
  sha256 "584db72abf6643927b2c3ba98ff793f602216b452b8ff2f34a8851d35904804a"
  license "GPL-3.0-or-later"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "c12949bf3279874fb43c38f066e4a8072d6c8b03742d3770c4081014f9f31162"
  end

  head "https://github.com/SRI-CSL/yices2.git", branch: "master"

  livecheck do
    url :stable
    regex(/^Yices[._-]v?(\d+(?:\.\d+)+)$/i)
  end


  depends_on "autoconf" => :build
  depends_on "gmp"

  uses_from_macos "gperf" => :build

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "autoconf"
    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-silent-rules", *std_configure_args
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"lra.smt2").write <<~EOF
      ;; QF_LRA = Quantifier-Free Linear Real Arithmetic
      (set-logic QF_LRA)
      ;; Declare variables x, y
      (declare-fun x () Real)
      (declare-fun y () Real)
      ;; Find solution to (x + y > 0), ((x < 0) || (y < 0))
      (assert (> (+ x y) 0))
      (assert (or (< x 0) (< y 0)))
      ;; Run a satisfiability check
      (check-sat)
      ;; Print the model
      (get-model)
    EOF
    output = shell_output("#{bin}/yices-smt2 #{testpath}/lra.smt2")
    assert_match "sat\n((define-fun x () Real 2.0)\n (define-fun y () Real (- 1.0)))\n", output
  end
end
