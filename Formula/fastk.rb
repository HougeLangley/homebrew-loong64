class Fastk < Formula
  desc "K-mer counter for high-fidelity shotgun datasets"
  homepage "https://github.com/thegenemyers/FASTK"
  url "https://github.com/thegenemyers/FASTK/archive/refs/tags/v1.2.tar.gz"
  sha256 "2e347fd698ea109685868149dd2d9c43aefc373f70ad7df8e303e0724f75c850"
  license all_of: [
    "BSD-3-Clause",
    { all_of: ["MIT", "BSD-3-Clause"] }, # HTSLIB
    "MIT", # LIBDEFLATE
  ]
  head "https://github.com/thegenemyers/FASTK.git", branch: "master"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "90f8886c379ab2770034ece7137f6ffbed4384b648c502d41f1e593b0ff63fb3"
  end

  depends_on "xz"

  uses_from_macos "bzip2"
  uses_from_macos "curl"

  on_linux do
    depends_on "zlib-ng-compat"
  end

  def install
    ENV.deparallelize

    bin.mkpath
    system "make"
    system "make", "install", "DEST_DIR=#{bin}"
  end

  test do
    (testpath/"test.fasta").write <<~EOS
      >U00096.2:1-70
      AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC
    EOS
    system bin/"FastK", "test.fasta"
    assert_path_exists "test.hist"
  end
end
