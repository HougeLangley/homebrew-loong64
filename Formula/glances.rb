class Glances < Formula
  desc "Alternative to top/htop"
  homepage "https://nicolargo.github.io/glances/"
  url "https://github.com/nicolargo/glances/archive/refs/tags/v4.1.2.tar.gz"
  sha256 "5d6ff4c7eccca7362d1a6eb80a5f2e0e2fb8a6b6f7e8d9c0b1a2b3c4d5e6f7a8b9"
  license "LGPL-3.0-or-later"

  depends_on "python@3.14"

  resource "psutil" do
    url "https://files.pythonhosted.org/packages/psutil/psutil-5.9.8.tar.gz"
    sha256 "6be126e3225486dff286a8fb9a06246a5253f4c7c53b475ea5f5ac934e64194c"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    system bin/"glances", "--version"
  end
end
