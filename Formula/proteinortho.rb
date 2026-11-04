class Proteinortho < Formula
  desc "Detecting orthologous genes within different species"
  homepage "https://gitlab.com/paulklemm_PHD/proteinortho"
  url "https://gitlab.com/paulklemm_PHD/proteinortho/-/archive/v6.3.6/proteinortho-v6.3.6.tar.gz"
  sha256 "2e41c9698bb7eaacdde242233e3a1643b429587d4b458577ecc5be2e752a2be5"
  license "GPL-3.0-or-later"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "37ef609020852105654156000d1671caeeb82110c2f7bf313b4ff73843957b20"
  end

  depends_on "diamond"
  depends_on "openblas"

  on_macos do
    depends_on "libomp"
  end

  def install
    ENV.cxx11

    # Enable OpenMP
    if OS.mac?
      ENV.append_to_cflags "-Xpreprocessor -fopenmp -I#{formula_opt_include("libomp")}"
      ENV.append "LDFLAGS", "-L#{formula_opt_lib("libomp")} -lomp"
    end

    bin.mkpath
    system "make", "install", "PREFIX=#{bin}"
    doc.install "manual.html"
    pkgshare.install "test"
  end

  test do
    system bin/"proteinortho", "-test"
    system bin/"proteinortho_clustering", "-test"

    # This test exercises OpenMP
    cp_r pkgshare/"test", testpath
    files = Dir[testpath/"test/*.faa"]
    system bin/"proteinortho", *files
  end
end
