class Talm < Formula
  desc "Manage Talos Linux configurations the GitOps way"
  homepage "https://example.org/talm"
  version "0.36.0"
  url "http://127.0.0.1:8080/brew/bottles/talm--0.36.0.loongarch64.bottle.tar.gz"
  sha256 "e7feccfb5152348b9a1ebc5ea1085aa9929580a1c544a8bfd41c3ee497a1abf3"

  def install
    bin.install "talm"
  end

  test do
    system "#{bin}/talm"
  end
end
