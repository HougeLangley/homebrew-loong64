class Aws-nuke < Formula
  desc "Remove all the resources from an AWS account"
  homepage "https://example.org/aws-nuke"
  version "3.68.3"
  url "http://127.0.0.1:8080/brew/bottles/aws-nuke--3.68.3.loongarch64.bottle.tar.gz"
  sha256 "725f015c5c7e0f7888bc70a10a7be86c7398bcdd4e502d89d7232902edaf77b0"

  def install
    bin.install "aws-nuke"
  end

  test do
    system "#{bin}/aws-nuke"
  end
end
