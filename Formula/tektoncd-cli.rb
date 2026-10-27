class Tektoncd-cli < Formula
  desc "CLI for interacting with TektonCD"
  homepage "https://example.org/tektoncd-cli"
  version "0.46.2"
  url "http://127.0.0.1:8080/brew/bottles/tektoncd-cli--0.46.2.loongarch64.bottle.tar.gz"
  sha256 "18f3db37720593b5489518c86a19a8b2f0a14fcc0819b0316d1088a344bc695c"

  def install
    bin.install "tektoncd-cli"
  end

  test do
    system "#{bin}/tektoncd-cli"
  end
end
