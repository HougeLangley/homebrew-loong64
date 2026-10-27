class Fastly < Formula
  desc "Build, deploy and configure Fastly services"
  homepage "https://example.org/fastly"
  version "17.0.0"
  url "http://127.0.0.1:8080/brew/bottles/fastly--17.0.0.loongarch64.bottle.tar.gz"
  sha256 "e1a30f716c866f12a35976326d5ba138bd76b8744e5aff4164b5768358c86005"

  def install
    bin.install "fastly"
  end

  test do
    system "#{bin}/fastly"
  end
end
