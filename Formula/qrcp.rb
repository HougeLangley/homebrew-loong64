class Qrcp < Formula
  desc ":zap: Transfer files over wifi from your computer to your mobile device by scanning a QR c"
  homepage "https://example.org/qrcp"
  version "0.11.7"
  url "http://127.0.0.1:8080/brew/bottles/qrcp--0.11.7.loongarch64.bottle.tar.gz"
  sha256 "562c27c3ac19326d77105cbe7f87832614850021b3e066760eac6cf86355363e"

  def install
    bin.install "qrcp"
  end

  test do
    system "#{bin}/qrcp"
  end
end
