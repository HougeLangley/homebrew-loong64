class Git-cliff < Formula
  desc "Highly customizable changelog generator"
  homepage "https://example.org/git-cliff"
  version "2.13.1"
  url "http://127.0.0.1:8080/brew/bottles/git-cliff--2.13.1.loongarch64.bottle.tar.gz"
  sha256 "baa5d08d355c5b988543a241c62bd42816b3d388f5a9ccd267505aeeffaeb3fd"

  def install
    bin.install "git-cliff"
  end

  test do
    system "#{bin}/git-cliff"
  end
end
