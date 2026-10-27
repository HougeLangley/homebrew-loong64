class Git-credential-oauth < Formula
  desc "A Git credential helper that securely authenticates to GitHub, GitLab and BitBucket using "
  homepage "https://example.org/git-credential-oauth"
  version "0.18.0"
  url "http://127.0.0.1:8080/brew/bottles/git-credential-oauth--0.18.0.loongarch64.bottle.tar.gz"
  sha256 "aa7d18138aca24f5cb6df8474b1b051e224299c2316a03480228621b69d28b58"

  def install
    bin.install "git-credential-oauth"
  end

  test do
    system "#{bin}/git-credential-oauth"
  end
end
