class Jenkins-cli < Formula
  desc "CLI for jenkins"
  homepage "https://example.org/jenkins-cli"
  version "0.0.47"
  url "http://127.0.0.1:8080/brew/bottles/jenkins-cli--0.0.47.loongarch64.bottle.tar.gz"
  sha256 "374b9426e3d15d1425541e68c0012cab78a1cf26ce250351ca244d38592942ac"

  def install
    bin.install "jenkins-cli"
  end

  test do
    system "#{bin}/jenkins-cli"
  end
end
