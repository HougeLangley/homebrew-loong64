class BashPreexec < Formula
  desc "Preexec and precmd functions for Bash (like Zsh)"
  homepage "https://github.com/rcaloras/bash-preexec"
  url "https://github.com/rcaloras/bash-preexec/archive/refs/tags/0.7.0.tar.gz"
  sha256 "f3d5698bde8533e9622b2ee2dcb0dd12e772d85018f4770a8899887ef6cd36a0"
  license "MIT"
  head "https://github.com/rcaloras/bash-preexec.git", branch: "master"


  deny_network_access!

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "ad3c7a252595bef526ebac68bbf0798fa7cfb08c58bc62a32dd8d4f50bdcb400"
  end

  def install
    (prefix/"etc/profile.d").install "bash-preexec.sh"
  end

  def caveats
    <<~EOS
      Add the following line to your bash profile (e.g. ~/.bashrc, ~/.profile, or ~/.bash_profile)
        [ -f #{etc}/profile.d/bash-preexec.sh ] && . #{etc}/profile.d/bash-preexec.sh
    EOS
  end

  test do
    # Just testing that the file is installed
    assert_path_exists testpath/"#{prefix}/etc/profile.d/bash-preexec.sh"
  end
end
