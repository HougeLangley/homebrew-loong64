class Mafft < Formula
  desc "Multiple alignments with fast Fourier transforms"
  homepage "https://mafft.cbrc.jp/alignment/software/"
  url "https://gitlab.com/sysimm/mafft.git",
      tag:      "v7.526",
      revision: "ee9799916df6a5d5103d46d54933f8eb6d28e244"
  license "BSD-3-Clause"

  livecheck do
    url :homepage
    regex(/The latest version is (\d+(?:\.\d+)+)/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "b955cd0a6d1dea7eef534b10c3e1f9557e5842f6a0cbac3599a5847f7c85f03b"
  end

  def install
    # Makefiles hardcode -std=c99; old-style prototypes need C17.
    cc = "#{ENV.cc} -std=gnu17 -Wno-error=incompatible-pointer-types -Wno-error=implicit-function-declaration"
    cxx = "#{ENV.cxx} -std=gnu++17 -Wno-error=incompatible-pointer-types -Wno-error=implicit-function-declaration"
    make_args = ["CC=#{cc}", "CXX=#{cxx}", "PREFIX=#{prefix}", "install"]
    system "make", "-C", "core", *make_args
    system "make", "-C", "extensions", *make_args
  end

  test do
    (testpath/"test.fa").write ">1\nA\n>2\nA"
    output = shell_output("#{bin}/mafft test.fa")
    assert_match ">1\na\n>2\na", output
  end
end
