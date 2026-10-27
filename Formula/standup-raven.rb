class Standup-raven < Formula
  desc "A Mattermost plugin for communicating daily standups across teams"
  homepage "https://example.org/standup-raven"
  version "3.3.2"
  url "http://127.0.0.1:8080/brew/bottles/standup-raven--3.3.2.loongarch64.bottle.tar.gz"
  sha256 "68b2c8537a100c8b1f29493f5c58020b26686a10c9faa43f070c144def82692c"

  def install
    bin.install "standup-raven"
  end

  test do
    system "#{bin}/standup-raven"
  end
end
