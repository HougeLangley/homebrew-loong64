class Liquidprompt < Formula
  desc "Adaptive prompt for bash and zsh shells"
  homepage "https://liquidprompt.readthedocs.io/en/stable/"
  url "https://github.com/liquidprompt/liquidprompt/archive/refs/tags/v2.3.0.tar.gz"
  sha256 "47e4af3211cad2c775eb5520926466c37ffc0a50ce7990be5b16f7dd291ef720"
  license "AGPL-3.0-or-later"
  head "https://github.com/liquidprompt/liquidprompt.git", branch: "master"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "c27efe57a2e59b3b99ad8b5bd6c091bf331da76074ccbe3b456edd3a0647120f"
  end

  def install
    share.install "liquidprompt"
  end

  def caveats
    <<~EOS
      Add the following lines to your bash or zsh config (e.g. ~/.bash_profile):
        if [ -f #{HOMEBREW_PREFIX}/share/liquidprompt ]; then
          . #{HOMEBREW_PREFIX}/share/liquidprompt
        fi

      If you'd like to reconfigure options, you may do so in ~/.liquidpromptrc.
    EOS
  end

  test do
    liquidprompt = "#{HOMEBREW_PREFIX}/share/liquidprompt"
    output = shell_output("/bin/bash -c '. #{liquidprompt} --no-activate; lp_theme --list'")
    assert_match "default\n", output
  end
end
