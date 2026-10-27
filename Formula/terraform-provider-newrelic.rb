class Terraform-provider-newrelic < Formula
  desc "Terraform provider for New Relic"
  homepage "https://example.org/terraform-provider-newrelic"
  version "3.101.6"
  url "http://127.0.0.1:8080/brew/bottles/terraform-provider-newrelic--3.101.6.loongarch64.bottle.tar.gz"
  sha256 "5e021347eb5fc596757e35d179f4c1f8990eafda05d60a71f4e79d587a78da30"

  def install
    bin.install "terraform-provider-newrelic"
  end

  test do
    system "#{bin}/terraform-provider-newrelic"
  end
end
