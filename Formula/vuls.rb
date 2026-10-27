class Vuls < Formula
  desc "Agent-less vulnerability scanner for Linux, FreeBSD, Container, WordPress, Programming lan"
  homepage "https://example.org/vuls"
  version "0.42.0"
  url "http://127.0.0.1:8080/brew/bottles/vuls--0.42.0.loongarch64.bottle.tar.gz"
  sha256 "47975376306e65334104785bdf4803bd6757af36e7320bf549be11cc8fd08aa6"

  def install
    bin.install "vuls"
  end

  test do
    system "#{bin}/vuls"
  end
end
