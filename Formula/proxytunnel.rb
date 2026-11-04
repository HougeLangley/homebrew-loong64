class Proxytunnel < Formula
  desc "Create TCP tunnels through HTTPS proxies"
  homepage "https://github.com/proxytunnel/proxytunnel"
  url "https://github.com/proxytunnel/proxytunnel/archive/refs/tags/v1.13.0.tar.gz"
  sha256 "1b1ae36327254cac351aa5358767c177b050ab4ce4a75fa100244da7816849e9"
  license "GPL-2.0-or-later" => { with: "x11vnc-openssl-exception" }


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "e0826d2e67bfa5cd5e0cf83aafa0c8b0d33cd888cb9515930172303174897e8a"
  end

  depends_on "asciidoc" => :build
  depends_on "xmlto" => :build
  depends_on "openssl@4"

  def install
    ENV["XML_CATALOG_FILES"] = etc/"xml/catalog"
    system "make"
    system "make", "install", "prefix=#{prefix}"
  end

  test do
    system bin/"proxytunnel", "--version"
  end
end
