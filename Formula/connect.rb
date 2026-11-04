class Connect < Formula
  desc "Provides SOCKS and HTTPS proxy support to SSH"
  homepage "https://github.com/gotoh/ssh-connect"
  url "https://github.com/gotoh/ssh-connect/archive/refs/tags/1.106.tar.gz"
  sha256 "4f07eec36e6da2c4641a9ea9a2fd0617d6fc6aff5b65b6433f8a6447bea8a002"
  license "GPL-2.0-or-later"
  head "https://github.com/gotoh/ssh-connect.git", branch: "master"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "3144872d0467de8b9172009ace67f37137bf73e707fddf585b953c43c8d387bc"
  end

  def install
    system "make"
    bin.install "connect"
  end

  test do
    system bin/"connect"
  end
end
