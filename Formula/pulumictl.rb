class Pulumictl < Formula
  desc "Swiss army knife for Pulumi development"
  homepage "https://example.org/pulumictl"
  version "0.0.50"
  url "http://127.0.0.1:8080/brew/bottles/pulumictl--0.0.50.loongarch64.bottle.tar.gz"
  sha256 "dae7711559225fa0f07c439f6ad6c4fea734f8714e3458d008842dd817a3d79e"

  def install
    bin.install "pulumictl"
  end

  test do
    system "#{bin}/pulumictl"
  end
end
