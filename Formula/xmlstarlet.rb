class Xmlstarlet < Formula
  desc "XML command-line utilities"
  homepage "https://xmlstarlet.github.io/"
  url "https://github.com/xmlstarlet/xmlstarlet/releases/download/1.7.0/xmlstarlet-1.7.0.tar.gz"
  sha256 "df4c93458fc6b2ad144d65dccf3ef251349871e0578c5bc59edbfeecf9bf3454"
  license "MIT"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "fb3624d210762f94cf3b7e5abaad23d68c01b9c09fec341ca995b57ab9073a43"
  end

  uses_from_macos "libxml2"
  uses_from_macos "libxslt"

  deny_network_access!


  def install
    system "./configure", "--disable-silent-rules", *std_configure_args
    system "make", "install"
    bin.install_symlink "xml" => "xmlstarlet"
  end

  test do
    system bin/"xmlstarlet", "--version"
  end
end
