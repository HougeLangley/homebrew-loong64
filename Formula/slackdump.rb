class Slackdump < Formula
  desc "Export Slack data without admin privileges"
  homepage "https://example.org/slackdump"
  version "4.5.2"
  url "http://127.0.0.1:8080/brew/bottles/slackdump--4.5.2.loongarch64.bottle.tar.gz"
  sha256 "4ad2a5ac703b0132e63f13672f6b9d2f2faf9db1d412a6efa3c1e99a9768ef06"

  def install
    bin.install "slackdump"
  end

  test do
    system "#{bin}/slackdump"
  end
end
