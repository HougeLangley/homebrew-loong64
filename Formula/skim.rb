class Skim < Formula
  desc "Fuzzy finder in Rust"
  homepage "https://example.org/skim"
  version "5.8.0"
  url "http://127.0.0.1:8080/brew/bottles/skim--5.8.0.loongarch64.bottle.tar.gz"
  sha256 "74975eed932eaf7fff3cc3cc27badc5f9129432f233a1be3e2db6d509b9884e9"

  def install
    bin.install "skim"
  end

  test do
    system "#{bin}/skim"
  end
end
