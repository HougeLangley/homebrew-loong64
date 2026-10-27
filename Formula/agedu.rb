class Agedu < Formula
  desc "Unix utility for tracking down wasted disk space"
  homepage "https://example.org/agedu"
  version "20260410"
  url "http://127.0.0.1:8080/brew/bottles/agedu--20260410.loongarch64.bottle.tar.gz"
  sha256 "d18bf9fb1c588d1f18ba20fad03ba3828c3dec2dc96a6412519a596cf1d825e3"

  def install
    bin.install "agedu"
  end

  test do
    system "#{bin}/agedu"
  end
end
