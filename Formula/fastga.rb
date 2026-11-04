class Fastga < Formula
  desc "Pairwise whole genome aligner"
  homepage "https://github.com/thegenemyers/FASTGA"
  url "https://github.com/thegenemyers/FASTGA/archive/refs/tags/v1.5.1.tar.gz"
  sha256 "cedd760e3faf61b03a40db75fcd304b46d60a17d3a5e868e6422162a6a522b47"
  license all_of: ["BSD-3-Clause", "MIT"]
  head "https://github.com/thegenemyers/FASTGA.git", branch: "main"


  on_linux do
    depends_on "zlib-ng-compat"
  end

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "065d0a03cded42f7173439d433bdd5b0ee891ff88bb18b909c459ee5352de842"
  end

  def install
    bin.mkpath
    system "make"
    system "make", "install", "DEST_DIR=#{bin}"
    pkgshare.install "EXAMPLE"
  end

  test do
    cp Dir["#{pkgshare}/EXAMPLE/HAP*.fasta.gz"], testpath
    system bin/"FastGA", "-vk", "-1:H1vH2", "HAP1", "HAP2"
    assert_path_exists "H1vH2.1aln"
  end
end
