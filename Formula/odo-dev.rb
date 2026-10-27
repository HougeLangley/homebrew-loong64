class Odo-dev < Formula
  desc "Developer-focused CLI for Kubernetes and OpenShift"
  homepage "https://example.org/odo-dev"
  version "3.16.1"
  url "http://127.0.0.1:8080/brew/bottles/odo-dev--3.16.1.loongarch64.bottle.tar.gz"
  sha256 "f32d5c59a36829dfe6536efea608fa10ffdb36c482b19def7d7afc7dc4e086e4"

  def install
    bin.install "odo-dev"
  end

  test do
    system "#{bin}/odo-dev"
  end
end
