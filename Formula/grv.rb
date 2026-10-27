class Grv < Formula
  desc "GRV is a terminal interface for viewing git repositories"
  homepage "https://example.org/grv"
  version "0.3.2"
  url "http://127.0.0.1:8080/brew/bottles/grv--0.3.2.loongarch64.bottle.tar.gz"
  sha256 "cc4137b5b401bfb3dff625de5d983136a27ce13c64df9c16839d29d867ae0bad"

  def install
    bin.install "grv"
  end

  test do
    system "#{bin}/grv"
  end
end
