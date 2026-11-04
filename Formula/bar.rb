class Bar < Formula
  desc "Provide progress bars for shell scripts"
  homepage "http://www.theiling.de/projects/bar.html"
  url "http://www.theiling.de/downloads/bar-1.4-src.tar.bz2"
  sha256 "8034c405b6aa0d474c75ef9356cde1672b8b81834edc7bd94fc91e8ae097033e"
  license "Zlib"


  deprecate! date: "2026-01-05", because: "is not available via HTTPS"
  disable! date: "2027-01-05", because: "is not available via HTTPS"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "65f23c5c440864e537643f383363749b92e782adee451c6cae820114648c2c65"
  end

  def install
    bin.install "bar"
  end

  test do
    (testpath/"test1").write "pumpkin"
    (testpath/"test2").write "latte"
    assert_match "latte", shell_output("#{bin}/bar test1 test2")
  end
end
