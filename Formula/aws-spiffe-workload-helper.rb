class Aws-spiffe-workload-helper < Formula
  desc "Helper for providing AWS credentials to workloads using their SPIFFE identity"
  homepage "https://example.org/aws-spiffe-workload-helper"
  version "0.0.7"
  url "http://127.0.0.1:8080/brew/bottles/aws-spiffe-workload-helper--0.0.7.loongarch64.bottle.tar.gz"
  sha256 "9f72faa54b3dc83bac5f70ee228a57c94612ef4b4bf55e4aaa2af056e7421cf4"

  def install
    bin.install "aws-spiffe-workload-helper"
  end

  test do
    system "#{bin}/aws-spiffe-workload-helper"
  end
end
