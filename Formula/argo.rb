class Argo < Formula
  desc "Get stuff done with container-native workflows for Kubernetes"
  homepage "https://example.org/argo"
  version "4.1.6"
  url "http://127.0.0.1:8080/brew/bottles/argo--4.1.6.loongarch64.bottle.tar.gz"
  sha256 "285df30bff10b4ba9f1dbc380d2a8ed1cc9680bb028f5ebb0060e4e1878915ba"

  def install
    bin.install "argo"
  end

  test do
    system "#{bin}/argo"
  end
end
