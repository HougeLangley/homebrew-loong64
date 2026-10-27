class Cadence-workflow < Formula
  desc "Distributed, scalable, durable, and highly available orchestration engine"
  homepage "https://example.org/cadence-workflow"
  version "1.4.2"
  url "http://127.0.0.1:8080/brew/bottles/cadence-workflow--1.4.2.loongarch64.bottle.tar.gz"
  sha256 "31b68827f633ebf89822bc40c47891e2a855088e6aba808958e882b464bb44f3"

  def install
    bin.install "cadence-workflow"
  end

  test do
    system "#{bin}/cadence-workflow"
  end
end
