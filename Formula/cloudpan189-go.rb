class Cloudpan189-go < Formula
  desc "Command-line client tool for Cloud189 web disk"
  homepage "https://example.org/cloudpan189-go"
  version "0.1.3"
  url "http://127.0.0.1:8080/brew/bottles/cloudpan189-go--0.1.3.loongarch64.bottle.tar.gz"
  sha256 "21fbc7eacc3483b07d3f2fea761cd86a1a70e683f32cb91cf4e16aa95942e85f"

  def install
    bin.install "cloudpan189-go"
  end

  test do
    system "#{bin}/cloudpan189-go"
  end
end
