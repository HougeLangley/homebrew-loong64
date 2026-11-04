class GitSecrets < Formula
  desc "Prevents you from committing sensitive information to a git repo"
  homepage "https://github.com/awslabs/git-secrets"
  license "Apache-2.0"
  head "https://github.com/awslabs/git-secrets.git", branch: "master"

  stable do
    url "https://github.com/awslabs/git-secrets/archive/refs/tags/1.3.0.tar.gz"
    sha256 "f1d50c6c5c7564f460ff8d279081879914abe920415c2923934c1f1d1fac3606"

    # Backport removal of unnecessary dependency on `say`
    patch do
      url "https://github.com/awslabs/git-secrets/commit/65891e23f341f159098300999edcce5983cd3ad8.patch?full_index=1"
      sha256 "add9ad9f5778dd38885a23b8b394601061a203d1862b91cd64c5ca2a0c9a6ab2"
      type :backport
      resolves "https://github.com/awslabs/git-secrets/pull/221"
    end
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "2cbd6b0e6c233b46ce602119b1ece9aa9b796ff47e40beb10e0c937d6798998d"
  end

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    system "git", "init"
    system "git", "secrets", "--install"
  end
end
