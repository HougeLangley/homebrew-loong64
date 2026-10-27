class Gitbackup < Formula
  desc "Tool to backup your Bitbucket, GitHub, GitLab and Forgejo repositories"
  homepage "https://example.org/gitbackup"
  version "1.3.1"
  url "http://127.0.0.1:8080/brew/bottles/gitbackup--1.3.1.loongarch64.bottle.tar.gz"
  sha256 "2a7f2ffadbfaeb766110146b12afd52528bc698bdb5d04f3c90b7e3151584e25"

  def install
    bin.install "gitbackup"
  end

  test do
    system "#{bin}/gitbackup"
  end
end
