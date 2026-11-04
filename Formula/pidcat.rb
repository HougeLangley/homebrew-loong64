class Pidcat < Formula
  include Language::Python::Shebang

  desc "Colored logcat script to show entries only for specified app"
  homepage "https://github.com/JakeWharton/pidcat"
  url "https://github.com/JakeWharton/pidcat/archive/refs/tags/2.1.0.tar.gz"
  sha256 "e6f999ee0f23f0e9c9aee5ad21c6647fb1a1572063bdccd16a72464c8b522cb1"
  license "Apache-2.0"
  head "https://github.com/JakeWharton/pidcat.git", branch: "master"


  uses_from_macos "python"

  bottle do
    rebuild 3
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "9bd9b9bd29db5955d95cb07e504b7db0409a358a55799f9f0c9510b38daf0e8a"
  end

  def install
    # FIXME: `detected_python_shebang` doesn't correctly handle shebang with arguments
    inreplace "pidcat.py", "#!/usr/bin/python -u", "#!/usr/bin/env -S python3 -u"
    bin.install "pidcat.py" => "pidcat"

    bash_completion.install "bash_completion.d/pidcat"
    zsh_completion.install "zsh-completion/_pidcat"
  end

  test do
    output = shell_output("#{bin}/pidcat com.oprah.bees.android 2>&1", 1)
    assert_match "No such file or directory: 'adb'", output

    assert_match version.to_s, shell_output("#{bin}/pidcat --version")
  end
end
