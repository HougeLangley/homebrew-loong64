class Fpp < Formula
  desc "CLI program that accepts piped input and presents files for selection"
  homepage "https://facebook.github.io/PathPicker/"
  url "https://github.com/facebook/PathPicker/archive/refs/tags/0.9.5.tar.gz"
  sha256 "b0142676ed791085d619d9b3d28d28cab989ffc3b260016766841c70c97c2a52"
  license "MIT"
  head "https://github.com/facebook/pathpicker.git", branch: "main"


  uses_from_macos "python"

  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "cc3387817dc574163738f360d69df8ee2ecfc333431042c10021716be922841a"
  end

  def install
    rm_r(buildpath/"src/tests")
    # we need to copy the bash file and source python files
    libexec.install "fpp", "src"
    # and then symlink the bash file
    bin.install_symlink libexec/"fpp"
    man1.install "debian/usr/share/man/man1/fpp.1"
  end

  test do
    system bin/"fpp", "--help"
  end
end
