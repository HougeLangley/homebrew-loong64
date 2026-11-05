class Taskopen < Formula
  desc "Tool for taking notes and open urls with taskwarrior"
  homepage "https://codeberg.org/jschlatow/taskopen"
  license "GPL-2.0-only"
  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "4a58c66c605a45b42f1d37cdcdb68eb54e91cd91123ca330c31eeb93569076eb"
  end

  head "https://codeberg.org/jschlatow/taskopen.git", branch: "master"

  stable do
    # TODO: Switch to codeberg on next release. Deferred to avoid checksum change
    url "https://github.com/jschlatow/taskopen/archive/refs/tags/v2.0.3.tar.gz"
    sha256 "fe16f839279e8baff96dcead55feb03997aebdaa3cee7a421dadc8e7cb8c1581"

    # Backport replacement of PCRE as Linux distros may not provide system copy
    # and brew `pcre` is deprecated. On macOS, can still use system PCRE.
    on_linux do
      patch do
        url "https://codeberg.org/jschlatow/taskopen/commit/555e27161057b38b5d30c1d9e2b0778d66b93622.diff"
        sha256 "b0356a7fd6dc47b77b6099b4c8fc38ed7a5932a6e059a0923985f85172e716f9"
        type :backport
      end
      patch do
        url "https://codeberg.org/jschlatow/taskopen/commit/2e89ece66cbc9a038f50774f1a15e9e93f4d2dac.diff"
        sha256 "2b30129c16bdf43761294a9f7c93653ce973bf81665c7b470f5e9ee487b6593d"
        type :backport
      end
    end
  end



  depends_on "nim" => :build
  depends_on "task"

  def install
    # Workaround for https://codeberg.org/jschlatow/taskopen/issues/180
    inreplace "taskopen.nimble", '"2.0.0alpha"', "\"#{stable.version}\""

    system "make", "install", "PREFIX=#{prefix}", "VERSION=#{version}"
  end

  test do
    touch testpath/".taskrc"
    touch testpath/".taskopenrc"

    system "task", "add", "BrewTest"
    system "task", "1", "annotate", "Notes"

    assert_match <<~EOS, shell_output("#{bin}/taskopen diagnostics")
      Taskopen:       #{version}
        Taskwarrior:    #{Formula["task"].version}
        Configuration:  #{testpath}/.taskopenrc
    EOS
  end
end
