class Wakatime-cli < Formula
  desc "Command line interface used by all WakaTime text editor plugins"
  homepage "https://example.org/wakatime-cli"
  version "2.28.0"
  url "http://127.0.0.1:8080/brew/bottles/wakatime-cli--2.28.0.loongarch64.bottle.tar.gz"
  sha256 "2ab1c95eb9d1a1b0fa8b6e6b0665c05d58cd712ed1e4acd109173d6f39edcd3d"

  def install
    bin.install "wakatime-cli"
  end

  test do
    system "#{bin}/wakatime-cli"
  end
end
