class Dive < Formula
  desc "Explore docker image layers"
  homepage "https://example.org/dive"
  version "0.13.1"
  url "http://127.0.0.1:8080/brew/bottles/dive--0.13.1.loongarch64.bottle.tar.gz"
  sha256 "60c662144eb983fdde3b794e2aa89f5b094bf7099d402d87fd85e626e656280c"

  def install
    bin.install "dive"
  end

  test do
    system "#{bin}/dive"
  end
end
