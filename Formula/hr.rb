class Hr < Formula
  desc "<hr />, for your terminal window"
  homepage "https://github.com/LuRsT/hr"
  url "https://github.com/LuRsT/hr/archive/refs/tags/1.5.tar.gz"
  sha256 "d4bb6e8495a8adaf7a70935172695d06943b4b10efcbfe4f8fcf6d5fe97ca251"
  license "MIT"
  head "https://github.com/LuRsT/hr.git", branch: "master"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "c6622dd3995d33b3f122bdfecd9a59e0eb0b413e345878e7e435f1e42b4711b3"
  end

  def install
    bin.install "hr"
    man1.install "hr.1"
  end

  test do
    system bin/"hr", "-#-"
  end
end
