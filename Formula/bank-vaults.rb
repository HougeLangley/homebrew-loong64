class Bank-vaults < Formula
  desc "A Vault swiss-army knife: A CLI tool to init, unseal and configure Vault (auth methods, se"
  homepage "https://example.org/bank-vaults"
  version "1.33.2"
  url "http://127.0.0.1:8080/brew/bottles/bank-vaults--1.33.2.loongarch64.bottle.tar.gz"
  sha256 "bd3994afdc6161235e6c07a39059fa00088dab9e49afd407b7b4916161655da2"

  def install
    bin.install "bank-vaults"
  end

  test do
    system "#{bin}/bank-vaults"
  end
end
