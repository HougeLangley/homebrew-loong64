class Telepresence < Formula
  desc "Local development against a remote Kubernetes or OpenShift cluster"
  homepage "https://example.org/telepresence"
  version "2.32.3"
  url "http://127.0.0.1:8080/brew/bottles/telepresence--2.32.3.loongarch64.bottle.tar.gz"
  sha256 "57253bf61371df86c2195befd798e2e56c01cc272c1caf096575499b8a2687e7"

  def install
    bin.install "telepresence"
  end

  test do
    system "#{bin}/telepresence"
  end
end
