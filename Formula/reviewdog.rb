class Reviewdog < Formula
  desc "🐶 Automated code review tool integrated with any code analysis tools regardless of program"
  homepage "https://example.org/reviewdog"
  version "0.21.2"
  url "http://127.0.0.1:8080/brew/bottles/reviewdog--0.21.2.loongarch64.bottle.tar.gz"
  sha256 "f42d8cb9f43e8d1c47abee55e0f8e8a975c6f67f8a6b821172645a9bc7116bda"

  def install
    bin.install "reviewdog"
  end

  test do
    system "#{bin}/reviewdog"
  end
end
