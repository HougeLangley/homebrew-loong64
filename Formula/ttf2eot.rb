class Ttf2eot < Formula
  desc "Convert TTF files to EOT"
  homepage "https://github.com/wget/ttf2eot"
  url "https://github.com/wget/ttf2eot/archive/refs/tags/v0.0.3.tar.gz"
  sha256 "f363c4f2841b6d0b0545b30462e3c202c687d002da3d5dec7e2b827a032a3a65"
  license any_of: ["LGPL-2.0-or-later", "BSD-2-Clause"]


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "4d0f8a4fa11afb5fa99223b9f9283f80a350cf108ff27cdd907a34db88397216"
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
      font_dir = "/usr/share/fonts/truetype/dejavu"
    end
    cp "#{font_dir}/#{font_name}.ttf", testpath
    system("#{bin}/ttf2eot < '#{font_name}.ttf' > '#{font_name}.eot'")
    assert_path_exists testpath/"#{font_name}.eot"
  end
end
