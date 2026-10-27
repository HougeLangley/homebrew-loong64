class Argonaut < Formula
  desc "Keyboard-first terminal UI for Argo CD. Browse apps, scope by clusters/namespaces/projects"
  homepage "https://example.org/argonaut"
  version "2.20.0"
  url "http://127.0.0.1:8080/brew/bottles/argonaut--2.20.0.loongarch64.bottle.tar.gz"
  sha256 "cbd1adf905be4ad843e6b408f8d75049526a436f5a31f032e05f1843ca2ae420"

  def install
    bin.install "argonaut"
  end

  test do
    system "#{bin}/argonaut"
  end
end
