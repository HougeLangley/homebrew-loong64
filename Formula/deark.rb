class Deark < Formula
  desc "File conversion utility for older formats"
  homepage "https://entropymine.com/deark/"
  url "https://entropymine.com/deark/releases/deark-1.7.3.tar.gz"
  sha256 "84f9e0134830389e4ab12c89dc09cf42a3f885ec551254e9fdc22952858add11"
  license "MIT"

  livecheck do
    url "https://entropymine.com/deark/releases/"
    regex(/href=.*?deark[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  # Backport for macOS workaround
  patch do
    url "https://github.com/jsummers/deark/commit/d9ad63f9331f7d804c4978a644272810e200eb4c.patch?full_index=1"
    sha256 "0b08bfdd88bd0ff99208c6eb96eb72fc91f421c633a55bfc2ec960c5ee74a1cf"
    type :backport
  end

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "11bc20345c9f00d51a7562df39630b44bb1888dee1356d9de4c56bad10e7a3e9"
  end

  def install
    system "make"
    bin.install "deark"
  end

  test do
    (testpath/"test.gz").write <<~EOS.unpack1("m")
      H4sICKU51VoAA3Rlc3QudHh0APNIzcnJ11HwyM9NTSpKLVfkAgBuKJNJEQAAAA==
    EOS
    system bin/"deark", "test.gz"
    file = (testpath/"output.000.test.txt").readlines.first
    assert_match "Hello, Homebrew!", file
  end
end
