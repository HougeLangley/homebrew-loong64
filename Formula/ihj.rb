class Ihj < Formula
  desc "An fzf-inspired issue tracker with vim mode and LLM-assisted backlog refinement. Jira toda"
  homepage "https://example.org/ihj"
  version "0.5.18"
  url "http://127.0.0.1:8080/brew/bottles/ihj--0.5.18.loongarch64.bottle.tar.gz"
  sha256 "0295484a58f4c305f183e69f8c723f9a4ab5ed4b7522b631604e961cf219ef82"

  def install
    bin.install "ihj"
  end

  test do
    system "#{bin}/ihj"
  end
end
