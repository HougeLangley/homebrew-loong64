class Harness < Formula
  desc "Harness Open Source is an end-to-end developer platform with Source Control Management, CI"
  homepage "https://example.org/harness"
  version "2.28.2"
  url "http://127.0.0.1:8080/brew/bottles/harness--2.28.2.loongarch64.bottle.tar.gz"
  sha256 "90041972ff06b9f91883168fef611f24921b9d85a9fbe2462995c83db7d7abcf"

  def install
    bin.install "harness"
  end

  test do
    system "#{bin}/harness"
  end
end
