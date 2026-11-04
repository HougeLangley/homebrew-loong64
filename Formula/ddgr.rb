class Ddgr < Formula
  include Language::Python::Shebang

  desc "DuckDuckGo from the terminal"
  homepage "https://github.com/jarun/ddgr"
  url "https://github.com/jarun/ddgr/archive/refs/tags/v2.2.tar.gz"
  sha256 "a858e0477ea339b64ae0427743ebe798a577c4d942737d8b3460bce52ac52524"
  license "GPL-3.0-or-later"


  uses_from_macos "python"

  bottle do
    rebuild 3
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "d02c7bbe26e503d08009d11dc2b021229b49d2eefb886f3b170990e20223c4c6"
  end

  def install
    rewrite_shebang detected_python_shebang(use_python_from_path: true), "ddgr"
    system "make", "install", "PREFIX=#{prefix}"
    bash_completion.install "auto-completion/bash/ddgr-completion.bash" => "ddgr"
    fish_completion.install "auto-completion/fish/ddgr.fish"
    zsh_completion.install "auto-completion/zsh/_ddgr"
  end

  test do
    ENV["PYTHONIOENCODING"] = "utf-8"
    assert_match "q:Homebrew", shell_output("#{bin}/ddgr --debug --noprompt Homebrew 2>&1")
  end
end
