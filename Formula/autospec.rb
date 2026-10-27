class Autospec < Formula
  desc "CLI for streamlined spec-driven development"
  homepage "https://example.org/autospec"
  version "0.12.1"
  url "http://127.0.0.1:8080/brew/bottles/autospec--0.12.1.loongarch64.bottle.tar.gz"
  sha256 "72a824a14964a2b87c7f771f24015b6f4247a6e4091800e22ac95e79ecbc0c95"

  def install
    bin.install "autospec"
  end

  test do
    system "#{bin}/autospec"
  end
end
