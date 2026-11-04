class GitRemoteGcrypt < Formula
  desc "GPG-encrypted git remotes"
  homepage "https://spwhitton.name/tech/code/git-remote-gcrypt/"
  url "https://github.com/spwhitton/git-remote-gcrypt/archive/refs/tags/1.5.tar.gz"
  sha256 "0a0b8359eccdd5d63eaa3b06b7a24aea813d7f1e8bf99536bdd60bc7f18dca03"
  license any_of: ["GPL-3.0-only", "GPL-2.0-or-later"]

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "67ee048d7144fb6ab496643ee3c3301beb293db51cc7f4e4e9ab4283d715264b"
  end

  depends_on "docutils" => :build

  def install
    ENV["prefix"] = prefix
    system "./install.sh"
  end

  test do
    assert_match("fetch\npush\n", pipe_output(bin/"git-remote-gcrypt", "capabilities\n", 0))
  end
end
