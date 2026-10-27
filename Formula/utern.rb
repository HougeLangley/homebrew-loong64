class Utern < Formula
  desc "Multi group and stream log tailing for AWS CloudWatch Logs."
  homepage "https://example.org/utern"
  version "0.1.6"
  url "http://127.0.0.1:8080/brew/bottles/utern--0.1.6.loongarch64.bottle.tar.gz"
  sha256 "fc25452840f810df1881505fd12cf66cd61a04ed3136cfe207cbe7d34d867986"

  def install
    bin.install "utern"
  end

  test do
    system "#{bin}/utern"
  end
end
