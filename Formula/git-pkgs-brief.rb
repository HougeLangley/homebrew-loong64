class Git-pkgs-brief < Formula
  desc "Tool that detects and reports a project's toolchain, configuration, and more"
  homepage "https://example.org/git-pkgs-brief"
  version "0.14.2"
  url "http://127.0.0.1:8080/brew/bottles/git-pkgs-brief--0.14.2.loongarch64.bottle.tar.gz"
  sha256 "15f8f4b96fb4fd949eb65b0ac31ab6062b9793890cd37e7f23c017641f7cad9d"

  def install
    bin.install "git-pkgs-brief"
  end

  test do
    system "#{bin}/git-pkgs-brief"
  end
end
