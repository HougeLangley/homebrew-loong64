class Httpstat < Formula
  include Language::Python::Shebang

  desc "Curl statistics made simple"
  homepage "https://github.com/reorx/httpstat"
  url "https://github.com/reorx/httpstat/archive/refs/tags/1.3.2.tar.gz"
  sha256 "56c45aebdb28160dd16c73cf23af8208c19b30ec0166790685dfec115df9c92f"
  license "MIT"


  uses_from_macos "curl"
  uses_from_macos "python"

  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "1520015685fb970433995c2bc7cd1fd052053f6cf4a8235840bfdffab176b954"
  end

  def install
    rw_info = python_shebang_rewrite_info("/usr/bin/env python3")
    rewrite_shebang rw_info, "httpstat.py"
    bin.install "httpstat.py" => "httpstat"
  end

  test do
    assert_match "HTTP", shell_output("#{bin}/httpstat https://github.com")
  end
end
