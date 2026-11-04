class Gti < Formula
  desc "ASCII-art displaying typo-corrector for commands"
  homepage "https://r-wos.org/hacks/gti"
  url "https://github.com/rwos/gti/archive/refs/tags/v1.9.1.tar.gz"
  sha256 "f8a3afdd3967fe7d88bd1b0b9f5cb62ae04dc9ba458238da91efc213f61a9cf9"
  license "MIT"
  head "https://github.com/rwos/gti.git", branch: "master"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "1acad3f7ea3b8a242ac9bb982d497f672d1728c51c6ac5a7e4e42610281c7947"
  end

  def install
    system "make", "CC=#{ENV.cc}", "CFLAGS=#{ENV.cflags}"
    bin.install "gti"
    man6.install "gti.6"

    bash_completion.install "completions/gti.bash" => "gti"
    zsh_completion.install "completions/gti.zsh" => "_gti"
  end

  test do
    system bin/"gti", "init"
    assert_path_exists testpath/".git"
  end
end
