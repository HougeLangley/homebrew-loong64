class Soba < Formula
  desc "Automated, encrypted Git repository backups from GitHub, GitLab, Bitbucket, Azure DevOps, "
  homepage "https://example.org/soba"
  version "1.5.5"
  url "http://127.0.0.1:8080/brew/bottles/soba--1.5.5.loongarch64.bottle.tar.gz"
  sha256 "2db618e0d22533bac4799cd740adbba8496443e6a9e0eae63b7a8afc5eca8182"

  def install
    bin.install "soba"
  end

  test do
    system "#{bin}/soba"
  end
end
