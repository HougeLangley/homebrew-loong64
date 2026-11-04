class C < Formula
  desc 'Compile and execute C "scripts" in one go'
  homepage "https://github.com/ryanmjacobs/c"
  url "https://github.com/ryanmjacobs/c/archive/refs/tags/v0.15.1.tar.gz"
  sha256 "ecfad78cb0ab56da44dcfed805f5c261ddefd6dc4a4e57eb2dcfcffa85330605"
  license "MIT"
  head "https://github.com/ryanmjacobs/c.git", branch: "master"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "1fcb7aa9aea0cb081fdf9b47bb7fcf81a31b0bc7aea15f8722c6459f268062ee"
  end

  def install
    bin.install "c"
  end

  test do
    (testpath/"test.c").write("int main(void){return 0;}")
    system bin/"c", testpath/"test.c"
  end
end
