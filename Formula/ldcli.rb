class Ldcli < Formula
  desc "CLI for managing LaunchDarkly feature flags"
  homepage "https://example.org/ldcli"
  version "3.14.0"
  url "http://127.0.0.1:8080/brew/bottles/ldcli--3.14.0.loongarch64.bottle.tar.gz"
  sha256 "8775a6053d1c12a60d85f3f187b7efaff06e218b24213a2f6a902d367e0c4b92"

  def install
    bin.install "ldcli"
  end

  test do
    system "#{bin}/ldcli"
  end
end
