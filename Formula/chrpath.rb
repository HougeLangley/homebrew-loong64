class Chrpath < Formula
  desc "Tool to edit the rpath in ELF binaries"
  homepage "https://tracker.debian.org/pkg/chrpath"
  url "https://deb.debian.org/debian/pool/main/c/chrpath/chrpath_0.18.orig.tar.gz"
  sha256 "f09c49f0618660ca11fc6d9580ddde904c7224d4c6d0f6f2d1f9bcdc9102c9aa"
  license "GPL-2.0-or-later"

  livecheck do
    skip "Not actively developed or maintained"
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "3ed0018a9e5932baadc5250eec1139fb5b8bd8aa54077022dd5a5cfb9b3e6ec8"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on :linux

  deny_network_access!

  def install
    system "autoreconf", "--force", "--install", "--verbose"
    system "./configure", *std_configure_args, "--disable-silent-rules"
    system "make", "install"
  end

  test do
    assert_match "chrpath version #{version}", shell_output("#{bin}/chrpath -v")
    (testpath/"test.c").write "int main(){return 0;}"
    system ENV.cc, "test.c", "-Wl,-rpath,/usr/local/lib"
    assert_match "a.out: RUNPATH=/usr/local/lib", shell_output("#{bin}/chrpath a.out")
    assert_match "a.out: new RUNPATH: /usr/lib/", shell_output("#{bin}/chrpath -r /usr/lib/ a.out")
    assert_match "a.out: RUNPATH=/usr/lib/",      shell_output("#{bin}/chrpath a.out")
    system bin/"chrpath", "-d", "a.out"
    assert_match "a.out: no rpath or runpath tag found.", shell_output("#{bin}/chrpath a.out", 2)
  end
end
