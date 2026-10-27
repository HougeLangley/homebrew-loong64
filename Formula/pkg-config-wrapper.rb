class Pkg-config-wrapper < Formula
  desc "Easier way to include C code in your Go program"
  homepage "https://example.org/pkg-config-wrapper"
  version "0.2.13"
  url "http://127.0.0.1:8080/brew/bottles/pkg-config-wrapper--0.2.13.loongarch64.bottle.tar.gz"
  sha256 "c87f102ad2ad40a5a219eb38bae76914f0d10c82586f922591424a9134c81e24"

  def install
    bin.install "pkg-config-wrapper"
  end

  test do
    system "#{bin}/pkg-config-wrapper"
  end
end
