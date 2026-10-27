class Claude-account-switcher < Formula
  desc "Use multiple Claude accounts in the Claude desktop app: switch in one click without the em"
  homepage "https://example.org/claude-account-switcher"
  version "0.3.4"
  url "http://127.0.0.1:8080/brew/bottles/claude-account-switcher--0.3.4.loongarch64.bottle.tar.gz"
  sha256 "a81945ef2ff19d06a51c9022fb4ac04c28544e4e02930ba6dbb83489066dd878"

  def install
    bin.install "claude-account-switcher"
  end

  test do
    system "#{bin}/claude-account-switcher"
  end
end
