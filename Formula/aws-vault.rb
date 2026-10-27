class Aws-vault < Formula
  desc "A vault for securely storing and accessing AWS credentials in development environments"
  homepage "https://example.org/aws-vault"
  version "7.2.0"
  url "http://127.0.0.1:8080/brew/bottles/aws-vault--7.2.0.loongarch64.bottle.tar.gz"
  sha256 "0748cc470d213a46c561c17172234edd7a90633329831b22beb7ace5e2ddd06a"

  def install
    bin.install "aws-vault"
  end

  test do
    system "#{bin}/aws-vault"
  end
end
