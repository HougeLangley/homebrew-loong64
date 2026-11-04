class Darkhttpd < Formula
  desc "Small static webserver without CGI"
  homepage "https://unix4lyfe.org/darkhttpd/"
  url "https://github.com/emikulic/darkhttpd/archive/refs/tags/v1.17.tar.gz"
  sha256 "4fee9927e2d8bb0a302f0dd62f9ff1e075748fa9f5162c9481a7a58b41462b56"
  license "ISC"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "9499bdfff5ba110bca2bb1cba849c78a894f52f220429d74cdd80601fca807ed"
  end

  def install
    system "make"
    bin.install "darkhttpd"
  end

  test do
    system bin/"darkhttpd", "--help"
  end
end
