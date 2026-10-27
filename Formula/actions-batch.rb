class Actions-batch < Formula
  desc "Time-sharing supercomputer built on GitHub Actions"
  homepage "https://example.org/actions-batch"
  version "0.0.3"
  url "http://127.0.0.1:8080/brew/bottles/actions-batch--0.0.3.loongarch64.bottle.tar.gz"
  sha256 "19578ca8971ca4980051cdf7e4de4d4ad8802c3fcfbce3a2619e6fd4a8451a6a"

  def install
    bin.install "actions-batch"
  end

  test do
    system "#{bin}/actions-batch"
  end
end
