class Kubescape < Formula
  desc "Kubescape is an open-source Kubernetes security platform for your IDE, CI/CD pipelines, an"
  homepage "https://example.org/kubescape"
  version "4.0.16"
  url "http://127.0.0.1:8080/brew/bottles/kubescape--4.0.16.loongarch64.bottle.tar.gz"
  sha256 "acf4e4e63b642b4dea6cd92e995fd26df66f1c9eb527f71e3359e88e50f9392f"

  def install
    bin.install "kubescape"
  end

  test do
    system "#{bin}/kubescape"
  end
end
