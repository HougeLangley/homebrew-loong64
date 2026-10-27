class Deepseek-reasonix < Formula
  desc "A reliable coding agent for complex software engineering tasks."
  homepage "https://example.org/deepseek-reasonix"
  version "studio-v2.53.1"
  url "http://127.0.0.1:8080/brew/bottles/deepseek-reasonix--studio-v2.53.1.loongarch64.bottle.tar.gz"
  sha256 "3467c3b5a8b79e6bb6973110992492b3394b3aae2663f7dd5abade6c3ab76eb6"

  def install
    bin.install "deepseek-reasonix"
  end

  test do
    system "#{bin}/deepseek-reasonix"
  end
end
