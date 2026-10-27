class Filebeat < Formula
  desc "File harvester to ship log files to Elasticsearch or Logstash"
  homepage "https://example.org/filebeat"
  version "9.5.5"
  url "http://127.0.0.1:8080/brew/bottles/filebeat--9.5.5.loongarch64.bottle.tar.gz"
  sha256 "cf0219ce30f62d8c4916d7b4b132724ab15ed3b61c7707937d49f9aed6b86511"

  def install
    bin.install "filebeat"
  end

  test do
    system "#{bin}/filebeat"
  end
end
