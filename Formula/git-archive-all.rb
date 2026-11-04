class GitArchiveAll < Formula
  include Language::Python::Shebang

  desc "Archive a project and its submodules"
  homepage "https://github.com/Kentzo/git-archive-all"
  url "https://github.com/Kentzo/git-archive-all/archive/refs/tags/1.23.1.tar.gz"
  sha256 "0c440d15be18e336672549231510fa3c66d0cb95069a5e4800fdd876ab6814df"
  license "MIT"
  head "https://github.com/Kentzo/git-archive-all.git", branch: "master"


  uses_from_macos "python"

  bottle do
    rebuild 5
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "443eb2ca267bf94c879953c6a8940c3c3d3eaa7d524f83ea14c0b10ac292d60b"
  end

  def install
    rewrite_shebang detected_python_shebang(use_python_from_path: true), "git_archive_all.py"

    system "make", "prefix=#{prefix}", "install"
  end

  test do
    system "git", "init"
    touch "homebrew"
    system "git", "add", "homebrew"
    system "git", "commit", "--message", "brewing"

    assert_equal "#{testpath.realpath}/homebrew => archive/homebrew",
                 shell_output("#{bin}/git-archive-all --dry-run ./archive").chomp
  end
end
