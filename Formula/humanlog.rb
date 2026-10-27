class Humanlog < Formula
  desc "Logs for humans to read"
  homepage "https://example.org/humanlog"
  version "0.7.8"
  url "http://127.0.0.1:8080/brew/bottles/humanlog--0.7.8.loongarch64.bottle.tar.gz"
  sha256 "d686f49d683da6923ca15f1eab117ec540ce3bc20ce333f175dd46766cabb219"

  def install
    bin.install "humanlog"
  end

  test do
    system "#{bin}/humanlog"
  end
end
