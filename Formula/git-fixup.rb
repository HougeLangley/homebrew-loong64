class GitFixup < Formula
  desc "Alias for git commit --fixup <ref>"
  homepage "https://github.com/keis/git-fixup"
  url "https://github.com/keis/git-fixup/archive/refs/tags/v1.6.1.tar.gz"
  sha256 "414d207687059094df9603c79d5e52343704e077b72777f25eda4d6ce291046e"
  license "ISC"
  head "https://github.com/keis/git-fixup.git", branch: "master"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "afbf6028fbd683343ce6e56306b0b1075de4588ae588f3281e6b9e57ce67e6f1"
  end

  def install
    system "make", "PREFIX=#{prefix}", "install"
    zsh_completion.install "completion.zsh" => "_git-fixup"
    fish_completion.install "completion.fish" => "git-fixup.fish"
  end

  test do
    system "git", "init"
    (testpath/"test").write "foo"
    system "git", "add", "test"
    system "git", "commit", "--message", "Initial commit"

    (testpath/"test").delete
    (testpath/"test").write "bar"
    system "git", "add", "test"
    system "git", "fixup"
  end
end
