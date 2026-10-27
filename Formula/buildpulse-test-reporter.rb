class Buildpulse-test-reporter < Formula
  desc "Connect your CI to BuildPulse to detect, track, and rank flaky tests"
  homepage "https://example.org/buildpulse-test-reporter"
  version "0.29.0"
  url "http://127.0.0.1:8080/brew/bottles/buildpulse-test-reporter--0.29.0.loongarch64.bottle.tar.gz"
  sha256 "94caeb9e0121278a4369f4ff57f91d6b14685e9b58f0c0df9c33beea1b9a135e"

  def install
    bin.install "buildpulse-test-reporter"
  end

  test do
    system "#{bin}/buildpulse-test-reporter"
  end
end
