class Go-test-report < Formula
  desc "Captures go test output and parses it into a single self-contained HTML file."
  homepage "https://example.org/go-test-report"
  version "0.9.3"
  url "http://127.0.0.1:8080/brew/bottles/go-test-report--0.9.3.loongarch64.bottle.tar.gz"
  sha256 "31f53c59551eea5438fc996465fd6d2815156938db231f0625984739291acf14"

  def install
    bin.install "go-test-report"
  end

  test do
    system "#{bin}/go-test-report"
  end
end
