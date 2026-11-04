class Chruby < Formula
  desc "Ruby environment tool"
  homepage "https://github.com/postmodern/chruby"
  url "https://github.com/postmodern/chruby/releases/download/v0.3.9/chruby-0.3.9.tar.gz"
  sha256 "7220a96e355b8a613929881c091ca85ec809153988d7d691299e0a16806b42fd"
  license "MIT"
  head "https://github.com/postmodern/chruby.git", branch: "master"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "4fd86d6f7ce6c168018f1f032649fd8eb9cdccef235dcf32ce5168964506a550"
  end

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end

  def caveats
    <<~EOS
      Add the following to the ~/.bash_profile or ~/.zshrc file:
        source #{opt_pkgshare}/chruby.sh

      To enable auto-switching of Rubies specified by .ruby-version files,
      add the following to ~/.bash_profile or ~/.zshrc:
        source #{opt_pkgshare}/auto.sh
    EOS
  end

  test do
    assert_equal "chruby version #{version}", shell_output("#{bin}/chruby-exec --version").strip
  end
end
