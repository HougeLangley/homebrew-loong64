class Dehydrated < Formula
  desc "LetsEncrypt/acme client implemented as a shell-script"
  homepage "https://dehydrated.io"
  url "https://github.com/dehydrated-io/dehydrated/archive/refs/tags/v0.7.2.tar.gz"
  sha256 "34d0e316dd86108cf302fddfe1c6d7b72c2fa98bed338ddd6c0155da2ec75a94"
  license "MIT"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "ff28aeedab0acf057dcc62862f6bb68db32debcd298d86348f02b9bf3b356812"
  end

  def install
    bin.install "dehydrated"
    man1.install "docs/man/dehydrated.1"

    # Build an `:all` bottle
    inreplace bin/"dehydrated", "/usr/local/etc/dehydrated", "#{HOMEBREW_PREFIX}/etc/dehydrated"
  end

  test do
    system bin/"dehydrated", "--help"
  end
end
