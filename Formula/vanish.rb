class Vanish < Formula
  desc "Modern safe file deletion tool with recovery - Never lose files again! Beautiful TUI, patt"
  homepage "https://example.org/vanish"
  version "0.9.5"
  url "http://127.0.0.1:8080/brew/bottles/vanish--0.9.5.loongarch64.bottle.tar.gz"
  sha256 "30cc90d0e965621b9352c8fb470529b60773a2b7eac05d4a40a76042ba711388"

  def install
    bin.install "vanish"
  end

  test do
    system "#{bin}/vanish"
  end
end
