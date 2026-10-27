class Osc < Formula
  desc "Access the system clipboard from anywhere using the ANSI OSC52 sequence"
  homepage "https://example.org/osc"
  version "0.4.8"
  url "http://127.0.0.1:8080/brew/bottles/osc--0.4.8.loongarch64.bottle.tar.gz"
  sha256 "ff02f0539743ca27b2f4db6fdd16f5065313e72618f41fe5566343e450752ab9"

  def install
    bin.install "osc"
  end

  test do
    system "#{bin}/osc"
  end
end
