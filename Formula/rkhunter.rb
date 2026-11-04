class Rkhunter < Formula
  desc "Rootkit hunter"
  homepage "https://rkhunter.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/rkhunter/rkhunter/1.4.6/rkhunter-1.4.6.tar.gz"
  sha256 "f750aa3e22f839b637a073647510d7aa3adf7496e21f3c875b7a368c71d37487"
  license "GPL-2.0-or-later"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "63774e0d6302694d1267b01ef72af58fa0a492cefdd1a637f9353140bee3f969"
  end

  def install
    system "./installer.sh", "--layout", "custom", prefix, "--install"
  end

  test do
    system bin/"rkhunter", "--version"
  end
end
