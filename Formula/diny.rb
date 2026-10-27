class Diny < Formula
  desc "Free AI git commit messages. No API key. No signup"
  homepage "https://example.org/diny"
  version "0.7.8"
  url "http://127.0.0.1:8080/brew/bottles/diny--0.7.8.loongarch64.bottle.tar.gz"
  sha256 "d64fe88d92d8b793bb84e6562f8607690e1264e630b491ff065ae4b0994eda63"

  def install
    bin.install "diny"
  end

  test do
    system "#{bin}/diny"
  end
end
