class Ipapatch < Formula
  desc "CLI tool to patch iOS IPA files and their plugins"
  homepage "https://example.org/ipapatch"
  version "2.1.3"
  url "http://127.0.0.1:8080/brew/bottles/ipapatch--2.1.3.loongarch64.bottle.tar.gz"
  sha256 "a26e8ec124eff97b2adf0a82fb51e622f7934c408631c45c0a775f94b46f3524"

  def install
    bin.install "ipapatch"
  end

  test do
    system "#{bin}/ipapatch"
  end
end
