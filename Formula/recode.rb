class Recode < Formula
  desc "Convert character set (charsets)"
  homepage "https://github.com/rrthomas/recode"
  url "https://github.com/rrthomas/recode/releases/download/v3.7.17/recode-3.7.17.tar.gz"
  sha256 "1b0aebe7283b79ff46bc0a06ee21faf65b4d0b304632cbc855721c25583d8ea3"
  license "GPL-3.0-or-later"

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "586ed475b6b2d6a6f8f6afac9b4a3502dc8a12f1e232e9cf3915874ce51a8ca0"
  end


  uses_from_macos "python" => :build

  on_macos do
    depends_on "gettext"
  end


  def install
    system "./configure", "--disable-silent-rules", *std_configure_args
    system "make", "install"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/recode --version")
  end
end
