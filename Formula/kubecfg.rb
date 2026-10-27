class Kubecfg < Formula
  desc "Manage complex enterprise Kubernetes environments as code"
  homepage "https://example.org/kubecfg"
  version "0.42.0"
  url "http://127.0.0.1:8080/brew/bottles/kubecfg--0.42.0.loongarch64.bottle.tar.gz"
  sha256 "1346736712db69f8b0da6d6cb004914f2c15502c9af01b748f8ad4ff637fe331"

  def install
    bin.install "kubecfg"
  end

  test do
    system "#{bin}/kubecfg"
  end
end
