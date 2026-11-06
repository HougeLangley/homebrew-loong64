class Jellyfish < Formula
  desc "Fast, memory-efficient counting of DNA k-mers"
  homepage "https://github.com/gmarcais/Jellyfish"
  url "https://github.com/gmarcais/Jellyfish/releases/download/v2.3.1/jellyfish-2.3.1.tar.gz"
  sha256 "ee032b57257948ca0f0610883099267572c91a635eecbd88ae5d8974c2430fcd"
  license any_of: ["BSD-3-Clause", "GPL-3.0-or-later"]

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "8a8d19093adf778401c66885b6eaa6ddf0673f2339385a817a88cafce6bdc361"
  end


  depends_on "pkgconf" => :build
  depends_on "htslib"

  # Fix -flat_namespace being used on Big Sur and later.
  patch do
    file "Patches/libtool/configure-big_sur.diff"
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", *std_configure_args
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.fa").write <<~EOS
      >Homebrew
      AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC
    EOS
    system bin/"jellyfish", "count", "-m17", "-s100M", "-t2", "-C", "test.fa"
    assert_match "1 54", shell_output("#{bin}/jellyfish histo mer_counts.jf")
    assert_match(/Unique:\s+54/, shell_output("#{bin}/jellyfish stats mer_counts.jf"))
  end
end
