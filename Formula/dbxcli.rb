class Dbxcli < Formula
  desc "A scriptable Dropbox CLI for files, shared links, teams, and automation workflows"
  homepage "https://example.org/dbxcli"
  version "3.7.4"
  url "http://127.0.0.1:8080/brew/bottles/dbxcli--3.7.4.loongarch64.bottle.tar.gz"
  sha256 "7e3a06ac5f19a137a52544fcfa3a820a269f1b297937753f30f9398387c65d02"

  def install
    bin.install "dbxcli"
  end

  test do
    system "#{bin}/dbxcli"
  end
end
