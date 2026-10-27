class Gtrash < Formula
  desc "Featureful Trash CLI manager: alternative to rm and trash-cli"
  homepage "https://example.org/gtrash"
  version "0.0.6"
  url "http://127.0.0.1:8080/brew/bottles/gtrash--0.0.6.loongarch64.bottle.tar.gz"
  sha256 "819717e84d1a886f03d53ca440f229226ff52da2a66bef5951571bfa33ac139c"

  def install
    bin.install "gtrash"
  end

  test do
    system "#{bin}/gtrash"
  end
end
