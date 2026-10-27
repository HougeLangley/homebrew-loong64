class Gitflow-toolkit < Formula
  desc "A simple toolkit for GitFlow."
  homepage "https://example.org/gitflow-toolkit"
  version "3.0.7"
  url "http://127.0.0.1:8080/brew/bottles/gitflow-toolkit--3.0.7.loongarch64.bottle.tar.gz"
  sha256 "bd4c853f223ed8fd940e271d44759f54b2ad0f5405eee3164ef1a20f27c5849f"

  def install
    bin.install "gitflow-toolkit"
  end

  test do
    system "#{bin}/gitflow-toolkit"
  end
end
