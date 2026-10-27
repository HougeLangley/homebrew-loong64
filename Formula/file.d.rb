class File.d < Formula
  desc "A blazing fast tool for building data pipelines: read, process and output events. Our comm"
  homepage "https://example.org/file.d"
  version "0.87.6"
  url "http://127.0.0.1:8080/brew/bottles/file.d--0.87.6.loongarch64.bottle.tar.gz"
  sha256 "8758ff197bf7a748e6b2a156130fff9830af220deea9e51b9f14fe5d9dae82f5"

  def install
    bin.install "file.d"
  end

  test do
    system "#{bin}/file.d"
  end
end
