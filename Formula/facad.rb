class Facad < Formula
  desc "Modern, colorful directory listing tool for the command-line"
  homepage "https://github.com/yellow-footed-honeyguide/facad"
  url "https://github.com/yellow-footed-honeyguide/facad/archive/refs/tags/v2.20.16.tar.gz"
  sha256 "4de8b7021efb0ec6f9bf71f0f70cb33e1cf52e945cc99e80760b80767dc380d7"
  license "MIT"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "53af0aa95c3bc080ce8bcbf4240d20898ef3e0e0c7c8e55844e2122ede75ad8f"
  end

  depends_on "meson" => :build
  depends_on "ninja" => :build

  def install
    system "meson", "setup", "build", *std_meson_args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"
  end

  test do
    assert_match "facad version #{version}", shell_output("#{bin}/facad --version")

    Dir.mkdir("foobar")
    assert_match "📁 foobar", shell_output(bin/"facad")
  end
end
