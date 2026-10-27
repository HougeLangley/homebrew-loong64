class Import-gitlab-commits < Formula
  desc "Import commits from a private GitLab repository in an anonymized way."
  homepage "https://example.org/import-gitlab-commits"
  version "0.7.1"
  url "http://127.0.0.1:8080/brew/bottles/import-gitlab-commits--0.7.1.loongarch64.bottle.tar.gz"
  sha256 "8f9375b7bdcd9fdffc990e3a63ea509434314475be57fbdf31cf6a7d2d46f283"

  def install
    bin.install "import-gitlab-commits"
  end

  test do
    system "#{bin}/import-gitlab-commits"
  end
end
