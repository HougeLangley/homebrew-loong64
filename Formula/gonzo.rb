class Gonzo < Formula
  desc "Gonzo! The Go based TUI log analysis tool"
  homepage "https://example.org/gonzo"
  version "0.4.3"
  url "http://127.0.0.1:8080/brew/bottles/gonzo--0.4.3.loongarch64.bottle.tar.gz"
  sha256 "4297c0ca40d0df0a113eea84aa0dc43153b0e7fea11b843be88f203314608895"

  def install
    bin.install "gonzo"
  end

  test do
    system "#{bin}/gonzo"
  end
end
