class Gnmic < Formula
  desc "GNMI CLI client and collector"
  homepage "https://example.org/gnmic"
  version "0.49.1"
  url "http://127.0.0.1:8080/brew/bottles/gnmic--0.49.1.loongarch64.bottle.tar.gz"
  sha256 "f24d303396915aa507a453f40b67b066690699854760307a0492d77ced52a688"

  def install
    bin.install "gnmic"
  end

  test do
    system "#{bin}/gnmic"
  end
end
