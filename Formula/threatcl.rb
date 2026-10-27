class Threatcl < Formula
  desc "Documenting your Threat Models with HCL"
  homepage "https://example.org/threatcl"
  version "0.6.11"
  url "http://127.0.0.1:8080/brew/bottles/threatcl--0.6.11.loongarch64.bottle.tar.gz"
  sha256 "f9391e42667134d3dd600229fd3dd56f58eda4e254ee3881d20987b38c0ed2f4"

  def install
    bin.install "threatcl"
  end

  test do
    system "#{bin}/threatcl"
  end
end
