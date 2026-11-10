class Ttf2eot < Formula
  desc "Convert TTF files to EOT"
  homepage "https://github.com/wget/ttf2eot"
  url "https://github.com/wget/ttf2eot/archive/refs/tags/v0.0.3.tar.gz"
  sha256 "f363c4f2841b6d0b0545b30462e3c202c687d002da3d5dec7e2b827a032a3a65"
  license any_of: ["LGPL-2.0-or-later", "BSD-2-Clause"]

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "29665070db6bd1bd1e19547b94984282aac7445fa340dd26befec8b04adc7016"
  end

  def install
    system "make"
    bin.install "ttf2eot"
  end

  test do
    if OS.mac?
      font_name = "Arial Unicode"
      font_dir = "/Library/Fonts"
    else
      font_name = "DejaVuSans"
      font_dir = "/usr/share/fonts/TTF"
    end
    cp "#{font_dir}/#{font_name}.ttf", testpath
    system("#{bin}/ttf2eot < '#{font_name}.ttf' > '#{font_name}.eot'")
    assert_path_exists testpath/"#{font_name}.eot"
    assert_operator (testpath/"#{font_name}.eot").size, :>, 0
  end
end
