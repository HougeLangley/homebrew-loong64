class File < Formula
  desc "Utility to determine file types"
  homepage "https://darwinsys.com/file/"
  url "https://astron.com/pub/file/file-5.46.tar.gz"
  sha256 "c9cc77c7c560c543135edc555af609d561ff0e1cf18ca25057e28202896dd847"
  license "BSD-2-Clause"

  depends_on "libmagic"

  def install
    system "./configure", "--prefix=#{prefix}", "--disable-silent-rules"
    system "make", "install"
  end

  test do
    system bin/"file", test_fixtures("test.png")
  end
end
