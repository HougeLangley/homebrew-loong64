class Trufflehog < Formula
  desc "Find, verify, and analyze leaked credentials"
  homepage "https://example.org/trufflehog"
  version "3.99.7"
  url "http://127.0.0.1:8080/brew/bottles/trufflehog--3.99.7.loongarch64.bottle.tar.gz"
  sha256 "ef81b5c29fbc2ab03326668ca263f7685144156e473f5f83a250f58bd51ef86d"

  def install
    bin.install "trufflehog"
  end

  test do
    system "#{bin}/trufflehog"
  end
end
