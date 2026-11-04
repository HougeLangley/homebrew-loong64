class Mdp < Formula
  desc "Command-line based markdown presentation tool"
  homepage "https://github.com/visit1985/mdp"
  url "https://github.com/visit1985/mdp/archive/refs/tags/1.0.19.tar.gz"
  sha256 "4043838ff3048a5234ea6e24ab42301ab78ff3f51ed6ba19c0c4711414f6a74a"
  license "GPL-3.0-or-later"
  head "https://github.com/visit1985/mdp.git", branch: "master"


  uses_from_macos "ncurses"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "0e65da182515ff999a5e5caadc6bdc177eaec0421e85562e36b5588ac09fdd5b"
  end

  def install
    system "make"
    system "make", "install", "PREFIX=#{prefix}"
    pkgshare.install "sample.md"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mdp -v")
  end
end
