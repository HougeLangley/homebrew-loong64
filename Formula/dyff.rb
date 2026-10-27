class Dyff < Formula
  desc "Diff tool for YAML files, and sometimes JSON"
  homepage "https://example.org/dyff"
  version "1.12.0"
  url "http://127.0.0.1:8080/brew/bottles/dyff--1.12.0.loongarch64.bottle.tar.gz"
  sha256 "7a063c65c25c888cea740977ac97accccbc058dc17f2763131938b1e9e628e7f"

  def install
    bin.install "dyff"
  end

  test do
    system "#{bin}/dyff"
  end
end
