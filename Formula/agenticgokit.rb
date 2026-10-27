class Agenticgokit < Formula
  desc "Open-source Agentic AI framework in Go for building, orchestrating, and deploying intellig"
  homepage "https://example.org/agenticgokit"
  version "0.5.9"
  url "http://127.0.0.1:8080/brew/bottles/agenticgokit--0.5.9.loongarch64.bottle.tar.gz"
  sha256 "c11b2784f34cf65f67a1c3ddc1c509f6f343e318abd34ef2f62e92bc8e8bf2c0"

  def install
    bin.install "agenticgokit"
  end

  test do
    system "#{bin}/agenticgokit"
  end
end
