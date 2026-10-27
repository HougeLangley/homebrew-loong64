class Mmdbctl < Formula
  desc "MMDB file management CLI supporting various operations on MMDB database files"
  homepage "https://example.org/mmdbctl"
  version "mmdbctl-1.5.1"
  url "http://127.0.0.1:8080/brew/bottles/mmdbctl--mmdbctl-1.5.1.loongarch64.bottle.tar.gz"
  sha256 "090873244ae707c68c6deeee778a17bcc258eb4f62543ea562a1313386a2b9af"

  def install
    bin.install "mmdbctl"
  end

  test do
    system "#{bin}/mmdbctl"
  end
end
