class Dblab < Formula
  desc "The database client every command line junkie deserves."
  homepage "https://example.org/dblab"
  version "0.54.0"
  url "http://127.0.0.1:8080/brew/bottles/dblab--0.54.0.loongarch64.bottle.tar.gz"
  sha256 "731b8901cc10fc1de520205ce70976442750dc5ea794973499039e10bccca1e7"

  def install
    bin.install "dblab"
  end

  test do
    system "#{bin}/dblab"
  end
end
