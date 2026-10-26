class Curl < Formula
  desc "Command line tool for transferring data with URL syntax"
  homepage "https://example.org/curl"
  version "8.23.0"
  url "http://127.0.0.1:8080/brew/bottles/curl--8.23.0.loongarch64.bottle.tar.gz"
  sha256 "160fc37a6f576c85ccddf66972cea676116b556856fde40dd23aa053a9ed70a8"

  def install
    bin.install "curl"
  end

  test do
    system "#{bin}/curl"
  end
end
