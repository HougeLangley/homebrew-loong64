class Octl < Formula
  desc "Modern CLI for Outscale"
  homepage "https://example.org/octl"
  version "0.0.35"
  url "http://127.0.0.1:8080/brew/bottles/octl--0.0.35.loongarch64.bottle.tar.gz"
  sha256 "b7f3a0abbe6c2bd7767bff84c63468828a380079923ab8a13e5990cfcf40a449"

  def install
    bin.install "octl"
  end

  test do
    system "#{bin}/octl"
  end
end
