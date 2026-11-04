class Jdupes < Formula
  desc "Duplicate file finder and an enhanced fork of 'fdupes'"
  homepage "https://codeberg.org/jbruchon/jdupes"
  url "https://codeberg.org/jbruchon/jdupes/archive/v1.31.3.tar.gz"
  sha256 "3f76188082330cc28d37788377f0ed06b0ba181fcd4d88827a59f26a0c396168"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "1c1871185651aae3aa1ce09fc4bed9541a55af2cf36e0a1912d4ef846f62287b"
  end

  depends_on "libjodycode"

  deny_network_access!

  def install
    system "make", "ENABLE_DEDUPE=1"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    touch "a"
    touch "b"
    (testpath/"c").write("unique file")
    dupes = shell_output("#{bin}/jdupes --zero-match .").strip.split("\n").map { |f| File.basename(f) }.sort
    assert_equal ["a", "b"], dupes
  end
end
