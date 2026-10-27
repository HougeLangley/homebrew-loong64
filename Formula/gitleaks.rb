class Gitleaks < Formula
  desc "Find secrets with Gitleaks 🔑"
  homepage "https://example.org/gitleaks"
  version "8.30.1"
  url "http://127.0.0.1:8080/brew/bottles/gitleaks--8.30.1.loongarch64.bottle.tar.gz"
  sha256 "f0a1c586d7fd614e1fb92558f4071f2c63e9861b90bd0a2df4875fa8912bdc1a"

  def install
    bin.install "gitleaks"
  end

  test do
    system "#{bin}/gitleaks"
  end
end
