class Drone-cli < Formula
  desc "Command-line client for the Drone continuous integration server"
  homepage "https://example.org/drone-cli"
  version "1.9.0"
  url "http://127.0.0.1:8080/brew/bottles/drone-cli--1.9.0.loongarch64.bottle.tar.gz"
  sha256 "df917df2fb5f1617b87e7232645f2fcf97b35eb4a3287658c3a19ca1bac4a14e"

  def install
    bin.install "drone-cli"
  end

  test do
    system "#{bin}/drone-cli"
  end
end
