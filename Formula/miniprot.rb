class Miniprot < Formula
  desc "Align proteins to genomes with splicing and frameshift"
  homepage "https://lh3.github.io/miniprot/"
  url "https://github.com/lh3/miniprot/archive/refs/tags/v0.18.tar.gz"
  sha256 "e1b5c08571fa3a4aa225da8ec9c6e744cd116b4dc50d9e187114cffe336921ee"
  license "MIT"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "236132d1a16215bf88cd4cd7b032f1a06488bac47925f742b9b6e42ff78dff90"
  end

  depends_on "simde" => :build

  on_linux do
    depends_on "zlib-ng-compat"
  end

  def install
    inreplace "nasw-sse.c",
              "#elif defined(__ARM_NEON)\n#include \"s2n-lite.h\"\n#endif",
              "#elif defined(__ARM_NEON)\n#include \"s2n-lite.h\"\n#else\n#define SIMDE_ENABLE_NATIVE_ALIASES\n#include <simde/x86/sse4.1.h>\n#define MINIPROT_SIMDE\n#endif"
    inreplace "nasw-sse.c",
              "static inline int ns_le_epi16(__m128i a, __m128i b)\n{\n#if defined(__SSE2__)",
              "static inline int ns_le_epi16(__m128i a, __m128i b)\n{\n#if defined(__SSE2__) || defined(MINIPROT_SIMDE)"
    inreplace "nasw-sse.c",
              "static inline int ns_le_epi32(__m128i a, __m128i b)\n{\n#if defined(__SSE2__)",
              "static inline int ns_le_epi32(__m128i a, __m128i b)\n{\n#if defined(__SSE2__) || defined(MINIPROT_SIMDE)"
    inreplace "nasw-sse.c",
              "#elif defined(__SSE2__)\n\treturn _mm_or_si128",
              "#elif defined(__SSE2__) || defined(MINIPROT_SIMDE)\n\treturn _mm_or_si128"
    inreplace "nasw-sse.c",
              "#elif defined(__SSE2__)\n\ta = _mm_max_epi16",
              "#elif defined(__SSE2__) || defined(MINIPROT_SIMDE)\n\ta = _mm_max_epi16"
    system "make", "INCLUDES=-I#{Formula["simde"].opt_include}"
    bin.install "miniprot"
    pkgshare.install "test"
  end

  test do
    require "digest"
    cp_r pkgshare/"test/.", testpath
    shell_output("#{bin}/miniprot DPP3-hs.gen.fa.gz DPP3-mm.pep.fa.gz > actual.paf 2> actual.log")
    assert_match "mapped 1 sequences", (testpath/"actual.log").read
    # Official x86_64 0.18-r281 bottle 5dbb2fde... generated these references.
    assert_equal "d303e5f39bf5c0002421bbc7d8cc3adf7827ef2610e32619b226d556cf343d04",
                 Digest::SHA256.file(testpath/"actual.paf").hexdigest
    shell_output("#{bin}/miniprot --gff --aln DPP3-hs.gen.fa.gz DPP3-mm.pep.fa.gz > actual.gff 2> actual-gff.log")
    assert_equal "8c5582bdd283eaf6bb424f7924c6a9468af9470949df6cc02082fec45950ec7d",
                 Digest::SHA256.file(testpath/"actual.gff").hexdigest
  end
end
