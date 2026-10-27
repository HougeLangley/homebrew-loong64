class Box-cli-maker < Formula
  desc "Render highly customizable boxes in the terminal"
  homepage "https://example.org/box-cli-maker"
  version "3.1.0"
  url "http://127.0.0.1:8080/brew/bottles/box-cli-maker--3.1.0.loongarch64.bottle.tar.gz"
  sha256 "c47bcd50048611caca32bcfcc9b0d5aedf926ccb09762d04beeed599d501895a"

  def install
    bin.install "box-cli-maker"
  end

  test do
    system "#{bin}/box-cli-maker"
  end
end
