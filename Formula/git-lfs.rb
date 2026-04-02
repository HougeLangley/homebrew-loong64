class GitLfs < Formula
  desc "Git extension for versioning large files"
  homepage "https://git-lfs.github.com/"
  url "https://github.com/git-lfs/git-lfs/releases/download/v3.6.1/git-lfs-v3.6.1.tar.gz"
  sha256 "24194e7d2a3ca80fe996c971088de936b8982737a8a72dc909d3ab956533d55e"
  license "MIT"

  depends_on "go" => :build
  depends_on "ronn" => :build
  depends_on "ruby"

  def install
    ENV["GIT_LFS_SHA"] = ""
    ENV["VERSION"] = version

    system "make"
    system "make", "man", "RONN=#{Formula["ronn"].bin}/ronn"

    bin.install "bin/git-lfs"
    man1.install Dir["man/man1/*.1"]
    man5.install Dir["man/man5/*.5"]
    man7.install Dir["man/man7/*.7"]
    doc.install Dir["man/html/*.html"]
  end

  test do
    system "git", "init"
    system "git", "lfs", "track", "test"
    system "git", "add", ".gitattributes"
  end
end
