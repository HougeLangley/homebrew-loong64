class Kubedog < Formula
  desc "Library to watch and follow kubernetes resources in CI/CD deploy pipelines"
  homepage "https://example.org/kubedog"
  version "0.13.0"
  url "http://127.0.0.1:8080/brew/bottles/kubedog--0.13.0.loongarch64.bottle.tar.gz"
  sha256 "34384d1f0317d1100b9a00723bfcc9e6bdd3e6524630c952971d4fc3a8ec1726"

  def install
    bin.install "kubedog"
  end

  test do
    system "#{bin}/kubedog"
  end
end
