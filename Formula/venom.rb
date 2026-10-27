class Venom < Formula
  desc "🐍 Manage and run your integration tests with efficiency - Venom run executors (script, HTT"
  homepage "https://example.org/venom"
  version "1.3.0"
  url "http://127.0.0.1:8080/brew/bottles/venom--1.3.0.loongarch64.bottle.tar.gz"
  sha256 "96ca220e42f496e285b1ef2754c6bf93549a6cecf023835b9bec4ee37d635bb4"

  def install
    bin.install "venom"
  end

  test do
    system "#{bin}/venom"
  end
end
