class Xe < Formula
  desc "Simple xargs and apply replacement"
  homepage "https://github.com/leahneukirchen/xe"
  url "https://github.com/leahneukirchen/xe/archive/refs/tags/v1.0.tar.gz"
  sha256 "1e2484c6295f4eb1c1b789d8edab4b728cf9ea7e4c40ef52a56073f9a273ce30"
  license :public_domain
  head "https://github.com/leahneukirchen/xe.git", branch: "master"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "8ff69fc662e984f7936fee81b6d279f4ffc3d03a516e7b4eb68996e27abbbf45"
  end

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    (testpath/"input").write "a\nb\nc\nd\n"
    assert_equal "b a\nd c\n", shell_output("#{bin}/xe -f #{testpath}/input -N2 -s 'echo $2 $1'")
  end
end
