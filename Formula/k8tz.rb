class K8tz < Formula
  desc "Kubernetes admission controller and a CLI tool to inject timezones into Pods and CronJobs"
  homepage "https://example.org/k8tz"
  version "0.21.0"
  url "http://127.0.0.1:8080/brew/bottles/k8tz--0.21.0.loongarch64.bottle.tar.gz"
  sha256 "08e57341bd0795ddf2db1eebdb166dfae2cadd8ddde32ed8af68763ea573f542"

  def install
    bin.install "k8tz"
  end

  test do
    system "#{bin}/k8tz"
  end
end
