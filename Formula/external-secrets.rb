class External-secrets < Formula
  desc "External Secrets Operator reads information from a third-party service like AWS Secrets Ma"
  homepage "https://example.org/external-secrets"
  version "helm-chart-2.14.0"
  url "http://127.0.0.1:8080/brew/bottles/external-secrets--helm-chart-2.14.0.loongarch64.bottle.tar.gz"
  sha256 "0abc193843e4ec5472e67afe87c655a2e28314e59ec81026ae27514bb76f9f2e"

  def install
    bin.install "external-secrets"
  end

  test do
    system "#{bin}/external-secrets"
  end
end
