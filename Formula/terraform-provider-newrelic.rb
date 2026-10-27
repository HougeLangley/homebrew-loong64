class Terraform-provider-newrelic < Formula
  desc "Terraform provider for New Relic"
  homepage "https://example.org/terraform-provider-newrelic"
  version "3.101.6"
  url "http://127.0.0.1:8080/brew/bottles/terraform-provider-newrelic--3.101.6.loongarch64.bottle.tar.gz"
  sha256 "08ca296e21fa681ad7dabd7e99e1b7381bcb5f811336c5f3a4e3c83ce4371e34"

  def install
    bin.install "terraform-provider-newrelic"
  end

  test do
    system "#{bin}/terraform-provider-newrelic"
  end
end
