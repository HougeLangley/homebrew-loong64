class Ropebwt3 < Formula
  desc "BWT construction and search"
  homepage "https://github.com/lh3/ropebwt3"
  url "https://github.com/lh3/ropebwt3/archive/refs/tags/v3.10.tar.gz"
  sha256 "072231015c834d7ffcdc621c9ae260dafebf9f22ed9a780fe0026c2e0a845c5a"
  license all_of: ["MIT", "Apache-2.0"]
  head "https://github.com/lh3/ropebwt3.git", branch: "master"

  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "4a0b683b78cb2e1f4749a77a1bce710bdc4f7e4b08b94e871826f5522e23a307"
  end


  on_macos do
    depends_on "libomp"
  end

  on_linux do
    depends_on "zlib-ng-compat"
  end


  def install
    args = []
    args << "LIBS=-L#{formula_opt_lib("libomp")} -lomp -lpthread -lz -lm" if OS.mac?
    system "make", *args
    bin.install "ropebwt3"
  end

  test do
    (testpath/"test.txt").write <<~EOS
      TGAACTCTACACAACATATTTTGTCACCAAG
    EOS
    system bin/"ropebwt3", "build", "test.txt", "-Ldo", "idx.fmd"
    assert_path_exists "idx.fmd"
  end
end
