class Jenv < Formula
  desc "Manage your Java environment"
  homepage "https://github.com/jenv/jenv"
  url "https://github.com/jenv/jenv/archive/refs/tags/0.6.0.tar.gz"
  sha256 "2897ac544007a2c651bb3c02985143c94f4e1234b9c3c6cb2e436442b17cbc74"
  license "MIT"
  head "https://github.com/jenv/jenv.git", branch: "master"


  deny_network_access!

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "85712d1f22435abac06fe5db2a50dc968560dca03a1529f0eca3046c45217487"
  end

  def install
    libexec.install Dir["*"]
    bin.write_exec_script libexec/"bin/jenv"
    fish_function.install_symlink Dir[libexec/"fish/*.fish"]
  end

  def caveats
    <<~EOS
      To activate jenv, add the following to your shell profile e.g. ~/.profile
      or ~/.zshrc:
        export PATH="$HOME/.jenv/bin:$PATH"
        eval "$(jenv init -)"
    EOS
  end

  test do
    shell_output("eval \"$(#{bin}/jenv init -)\" && jenv versions")
  end
end
