class Easycron < Formula
  desc "Easycron is a simple cross platform cli app that helps to configure cron jobs."
  homepage "https://example.org/easycron"
  version "0.0.3"
  url "http://127.0.0.1:8080/brew/bottles/easycron--0.0.3.loongarch64.bottle.tar.gz"
  sha256 "75bace0abcc161f24055973c72b0a447cef0899eaa83eaf7979314eb11498d92"

  def install
    bin.install "easycron"
  end

  test do
    system "#{bin}/easycron"
  end
end
