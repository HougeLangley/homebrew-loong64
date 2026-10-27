class Glance < Formula
  desc "A self-hosted dashboard that puts all your feeds in one place"
  homepage "https://example.org/glance"
  version "0.8.7"
  url "http://127.0.0.1:8080/brew/bottles/glance--0.8.7.loongarch64.bottle.tar.gz"
  sha256 "b572a30ff9566404c20b118610de0c8fdb22590b364d4d32a934a0ee22143a1e"

  def install
    bin.install "glance"
  end

  test do
    system "#{bin}/glance"
  end
end
