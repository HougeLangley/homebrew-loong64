class Grap < Formula
  desc "Language for typesetting graphs"
  homepage "https://www.lunabase.org/~faber/Vault/software/grap/"
  url "https://www.lunabase.org/~faber/Vault/software/grap/grap-1.49.tar.gz"
  sha256 "f0bc7f09641a5ec42f019da64b0b2420d95c223b91b3778ae73cb68acfdf4e23"
  license "BSD-2-Clause"

  livecheck do
    url :homepage
    regex(/href=.*?grap[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  uses_from_macos "bison" => :build
  uses_from_macos "flex" => :build

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "5b8b4c9958c738993979254e2d83c0cb91d91af9815f41d246304b7ac0f0be55"
  end

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}",
                          "--with-example-dir=#{pkgshare}/examples"
    system "make"
    ENV.deparallelize
    system "make", "install"
  end

  test do
    (testpath/"test.d").write <<~EOS
      .G1
      54.2
      49.4
      49.2
      50.0
      48.2
      43.87
      .G2
    EOS
    system bin/"grap", testpath/"test.d"
  end
end
