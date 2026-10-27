class Kratos < Formula
  desc "Your ultimate Go microservices framework for the cloud-native era."
  homepage "https://example.org/kratos"
  version "3.0.0"
  url "http://127.0.0.1:8080/brew/bottles/kratos--3.0.0.loongarch64.bottle.tar.gz"
  sha256 "08da9b2bf85e398919f413a24e41da75c60e5e104f0d5a26c9766301751a7fa5"

  def install
    bin.install "kratos"
  end

  test do
    system "#{bin}/kratos"
  end
end
