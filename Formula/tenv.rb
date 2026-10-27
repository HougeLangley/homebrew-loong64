class Tenv < Formula
  desc "OpenTofu / Terraform / Terragrunt / Terramate / Atmos version manager"
  homepage "https://example.org/tenv"
  version "4.15.1"
  url "http://127.0.0.1:8080/brew/bottles/tenv--4.15.1.loongarch64.bottle.tar.gz"
  sha256 "a6a3377058e968d856559748ffeb1ec57e264e7f352765a2f260e37b7503845c"

  def install
    bin.install "tenv"
  end

  test do
    system "#{bin}/tenv"
  end
end
