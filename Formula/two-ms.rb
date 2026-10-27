class Two-ms < Formula
  desc "Detect secrets in files and communication platforms"
  homepage "https://example.org/two-ms"
  version "5.4.0"
  url "http://127.0.0.1:8080/brew/bottles/two-ms--5.4.0.loongarch64.bottle.tar.gz"
  sha256 "639df79ddfa397e26f503723cebb8ad27c32cb6b5fd678336dc3d1fa82774c1c"

  def install
    bin.install "two-ms"
  end

  test do
    system "#{bin}/two-ms"
  end
end
