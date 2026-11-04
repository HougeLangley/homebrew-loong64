class GitWhenMerged < Formula
  include Language::Python::Shebang

  desc "Find where a commit was merged in git"
  homepage "https://github.com/mhagger/git-when-merged"
  url "https://github.com/mhagger/git-when-merged/archive/refs/tags/v1.2.1.tar.gz"
  sha256 "46ba5076981862ac2ad0fa0a94b9a5401ef6b5c5b0506c6e306b76e5798e1f58"
  license "GPL-2.0-only"
  head "https://github.com/mhagger/git-when-merged.git", branch: "master"


  uses_from_macos "python"

  bottle do
    rebuild 6
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "d400e6233ad23c13304aa73e353a9e16f6662d287219639e5676b0775ec7cc89"
  end

  def install
    rewrite_shebang detected_python_shebang(use_python_from_path: true), "src/git_when_merged.py"
    bin.install "src/git_when_merged.py" => "git-when-merged"
  end

  test do
    system "git", "init", "--initial-branch", "master"
    system "git", "config", "user.name", "BrewTestBot"
    system "git", "config", "user.email", "BrewTestBot@example.com"
    touch "foo"
    system "git", "add", "foo"
    system "git", "commit", "-m", "foo"
    system "git", "checkout", "-b", "bar"
    touch "bar"
    system "git", "add", "bar"
    system "git", "commit", "-m", "bar"
    system "git", "checkout", "master"
    system "git", "merge", "--no-ff", "bar"
    touch "baz"
    system "git", "add", "baz"
    system "git", "commit", "-m", "baz"
    system bin/"git-when-merged", "bar"
  end
end
