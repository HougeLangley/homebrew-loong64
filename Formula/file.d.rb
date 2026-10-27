class File.d < Formula
  desc "A blazing fast tool for building data pipelines: read, process and output events. Our comm"
  homepage "https://example.org/file.d"
  version "0.87.6"
  url "http://127.0.0.1:8080/brew/bottles/file.d--0.87.6.loongarch64.bottle.tar.gz"
  sha256 "3b6f1dd0bb1b94cecf9613122f21e104a70fd083c661dac2a1ba6bbf60d998d4"

  def install
    bin.install "file.d"
  end

  test do
    system "#{bin}/file.d"
  end
end
