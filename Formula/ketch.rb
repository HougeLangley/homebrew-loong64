class Ketch < Formula
  desc "Web search and scraping for agents"
  homepage "https://example.org/ketch"
  version "0.20.0"
  url "http://127.0.0.1:8080/brew/bottles/ketch--0.20.0.loongarch64.bottle.tar.gz"
  sha256 "ca3f539f4ff5508e0f4933de930599836f5d82833c5b79ee816d8b383505e94d"

  def install
    bin.install "ketch"
  end

  test do
    system "#{bin}/ketch"
  end
end
