class Lsof < Formula
  desc "Utility to list open files"
  homepage "https://github.com/lsof-org/lsof"
  url "https://github.com/lsof-org/lsof/releases/download/4.99.3/lsof-4.99.3.tar.gz"
  sha256 "b9c56468b927d9691ab168c0b1e9f9f1faba14039372574d57f4550f326f6106"
  license "Zlib"

  depends_on "libtirpc"

  def install
    system "./configure", "--prefix=#{prefix}
    system "make"
    system "make", "install"
  end

  test do
    system bin/"lsof", "-v"
  end
end
