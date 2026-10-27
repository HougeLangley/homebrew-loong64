class Pachyderm < Formula
  desc "Data-Centric Pipelines and Data Versioning"
  homepage "https://example.org/pachyderm"
  version "2.12.2"
  url "http://127.0.0.1:8080/brew/bottles/pachyderm--2.12.2.loongarch64.bottle.tar.gz"
  sha256 "1961cb5c073cc3a20bb506da6223b377aa11276591e5d75e1961cff37ee126b9"

  def install
    bin.install "pachyderm"
  end

  test do
    system "#{bin}/pachyderm"
  end
end
