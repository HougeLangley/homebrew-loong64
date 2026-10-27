class Ddns-updater < Formula
  desc "Container to update DNS records periodically with WebUI for many DNS providers"
  homepage "https://example.org/ddns-updater"
  version "2.10.0"
  url "http://127.0.0.1:8080/brew/bottles/ddns-updater--2.10.0.loongarch64.bottle.tar.gz"
  sha256 "8b0c6d6727dded6ddd5e03caf87e200336f4301fa9485579fa8f9ddbc0fb4a5f"

  def install
    bin.install "ddns-updater"
  end

  test do
    system "#{bin}/ddns-updater"
  end
end
