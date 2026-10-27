class Mpb < Formula
  desc "multi progress bar for Go cli applications"
  homepage "https://example.org/mpb"
  version "8.16.2"
  url "http://127.0.0.1:8080/brew/bottles/mpb--8.16.2.loongarch64.bottle.tar.gz"
  sha256 "825a2f118d4727989a4a74de563ac54896842128c236db889dba2b2dc93b3536"

  def install
    bin.install "mpb"
  end

  test do
    system "#{bin}/mpb"
  end
end
