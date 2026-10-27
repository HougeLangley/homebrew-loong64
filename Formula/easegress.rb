class Easegress < Formula
  desc "A Cloud Native traffic orchestration system. (CNCF Project)"
  homepage "https://example.org/easegress"
  version "2.11.0"
  url "http://127.0.0.1:8080/brew/bottles/easegress--2.11.0.loongarch64.bottle.tar.gz"
  sha256 "67775eb4fb2797f212b64cb553e5914f17bd357cac052ba8ba3c240a17e051b4"

  def install
    bin.install "easegress"
  end

  test do
    system "#{bin}/easegress"
  end
end
