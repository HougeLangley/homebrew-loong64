class Ranger < Formula
  desc "File browser"
  homepage "https://ranger.github.io/"
  url "https://ranger.github.io/ranger-1.9.4.tar.gz"
  sha256 "7c32f9608009a36ada1b429dcb82e96cb836670cf87c8caf27c489f7dc7ff985"
  license "GPL-3.0-or-later"
  head "https://github.com/ranger/ranger.git", branch: "master"

  depends_on "python@3.14"

  def install
    virtualenv_install_with_resources
  end

  test do
    system bin/"ranger", "--version"
  end
end
