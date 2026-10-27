class Rolesanywhere-credential-helper < Formula
  desc "Manages getting temporary security credentials from IAM Roles Anywhere"
  homepage "https://example.org/rolesanywhere-credential-helper"
  version "1.8.5"
  url "http://127.0.0.1:8080/brew/bottles/rolesanywhere-credential-helper--1.8.5.loongarch64.bottle.tar.gz"
  sha256 "86bf1c25e7a4e22a7dc38930267c5d6e6b4ccae855e43790b048221dd81341ab"

  def install
    bin.install "rolesanywhere-credential-helper"
  end

  test do
    system "#{bin}/rolesanywhere-credential-helper"
  end
end
