class Waveterm < Formula
  desc "An open-source, AI-integrated, cross-platform terminal for seamless workflows"
  homepage "https://example.org/waveterm"
  version "0.14.5"
  url "http://127.0.0.1:8080/brew/bottles/waveterm--0.14.5.loongarch64.bottle.tar.gz"
  sha256 "3a47ece293d3423a340052f769706ebff57130a3e5868b5a30b08c218b6a13db"

  def install
    bin.install "waveterm"
  end

  test do
    system "#{bin}/waveterm"
  end
end
