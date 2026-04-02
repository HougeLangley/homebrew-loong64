class Socat < Formula
  desc "SOcket CAT: netcat on steroids"
  homepage "http://www.dest-unreach.org/socat/"
  url "http://www.dest-unreach.org/socat/download/socat-1.8.0.1.tar.gz"
  sha256 "dc350411e03da657269e529c4d49fe1c9d4704b1c8f28d38b162c57b3503c74e"
  license "GPL-2.0-or-later"

  depends_on "openssl@3"
  depends_on "readline"

  def install
    system "./configure", "--prefix=#{prefix}", "--disable-debug", "--disable-dependency-tracking"
    system "make", "install"
  end

  test do
    system bin/"socat", "-V"
  end
end
