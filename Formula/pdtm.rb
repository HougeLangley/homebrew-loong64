class Pdtm < Formula
  desc "ProjectDiscovery's Open Source Tool Manager"
  homepage "https://example.org/pdtm"
  version "0.1.5"
  url "http://127.0.0.1:8080/brew/bottles/pdtm--0.1.5.loongarch64.bottle.tar.gz"
  sha256 "064a0dfa8564f2bd3e54f883d84daa8ea498cea1bf0d64be8ee348ee36801ea3"

  def install
    bin.install "pdtm"
  end

  test do
    system "#{bin}/pdtm"
  end
end
