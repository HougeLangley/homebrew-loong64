class Ipatool < Formula
  desc "Command-line tool that allows you to search for iOS, iPadOS, tvOS, watchOS, visionOS, and "
  homepage "https://example.org/ipatool"
  version "2.7.0"
  url "http://127.0.0.1:8080/brew/bottles/ipatool--2.7.0.loongarch64.bottle.tar.gz"
  sha256 "072bae872c7ec8f77717df8cd252381c211716d1c736ee4da33482c58ad9e6c5"

  def install
    bin.install "ipatool"
  end

  test do
    system "#{bin}/ipatool"
  end
end
