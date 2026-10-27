class Starboard < Formula
  desc "Superseded by https://github.com/aquasecurity/trivy-operator"
  homepage "https://example.org/starboard"
  version "0.15.38"
  url "http://127.0.0.1:8080/brew/bottles/starboard--0.15.38.loongarch64.bottle.tar.gz"
  sha256 "141501c65b20ff8e539395d8033cc35c7f06a786847251fbdbc81939763cc631"

  def install
    bin.install "starboard"
  end

  test do
    system "#{bin}/starboard"
  end
end
