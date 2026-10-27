class Actions-runner-controller < Formula
  desc "Kubernetes controller for GitHub Actions self-hosted runners"
  homepage "https://example.org/actions-runner-controller"
  version "gha-runner-scale-set-0.15.1"
  url "http://127.0.0.1:8080/brew/bottles/actions-runner-controller--gha-runner-scale-set-0.15.1.loongarch64.bottle.tar.gz"
  sha256 "2d9895557c12b448502d8dd653c583a71db10c64137ce9e854984a1dfc197e2e"

  def install
    bin.install "actions-runner-controller"
  end

  test do
    system "#{bin}/actions-runner-controller"
  end
end
