class Agent-manager < Formula
  desc "The fastest developer workflow for every AI coding agent. Live status, quick prompts, work"
  homepage "https://example.org/agent-manager"
  version "0.44.0"
  url "http://127.0.0.1:8080/brew/bottles/agent-manager--0.44.0.loongarch64.bottle.tar.gz"
  sha256 "d9be46163e978ed74c7e2f0ca0f8792f4c5449fbaede58ad40ca508cc914e571"

  def install
    bin.install "agent-manager"
  end

  test do
    system "#{bin}/agent-manager"
  end
end
