class Hush < Formula
  desc "Context-efficient command runner for coding agents."
  homepage "https://example.org/hush"
  version "0.3.0"
  url "http://127.0.0.1:8080/brew/bottles/hush--0.3.0.loongarch64.bottle.tar.gz"
  sha256 "4a53764ffb2a1f5314d592eac899b700ba29772030baa8dd4add9dfa65245106"

  def install
    bin.install "hush"
  end

  test do
    system "#{bin}/hush"
  end
end
