class Aeman < Formula
  desc "A short-term planning system for engineering teams — keep engineers focused, run daily spr"
  homepage "https://example.org/aeman"
  version "0.33.1"
  url "http://127.0.0.1:8080/brew/bottles/aeman--0.33.1.loongarch64.bottle.tar.gz"
  sha256 "3eef0d8ad4bd138ca636875b0d0ddb1cadda9b10e9d847e9c6bfd6cff4d05e2d"

  def install
    bin.install "aeman"
  end

  test do
    system "#{bin}/aeman"
  end
end
