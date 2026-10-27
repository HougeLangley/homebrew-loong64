class Go-bindata < Formula
  desc "Small utility that generates Go code from any file"
  homepage "https://example.org/go-bindata"
  version "4.0.2"
  url "http://127.0.0.1:8080/brew/bottles/go-bindata--4.0.2.loongarch64.bottle.tar.gz"
  sha256 "80efee7a3c1a8773d4f2b5da18ae6191d00ee117e816dfe70c512d168c47f464"

  def install
    bin.install "go-bindata"
  end

  test do
    system "#{bin}/go-bindata"
  end
end
