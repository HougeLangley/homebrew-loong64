class Aws-iam-authenticator < Formula
  desc "Use AWS IAM credentials to authenticate to Kubernetes"
  homepage "https://example.org/aws-iam-authenticator"
  version "0.7.24"
  url "http://127.0.0.1:8080/brew/bottles/aws-iam-authenticator--0.7.24.loongarch64.bottle.tar.gz"
  sha256 "abc5fd66ad9c14b7bbf8fd05833ad2a7e55aff72bccd0d9474fd69e836a865b5"

  def install
    bin.install "aws-iam-authenticator"
  end

  test do
    system "#{bin}/aws-iam-authenticator"
  end
end
