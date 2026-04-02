class PythonAT313 < Formula
  desc "Interpreted, interactive, object-oriented programming language"
  homepage "https://www.python.org/"
  url "https://www.python.org/ftp/python/3.13.2/Python-3.13.2.tgz"
  sha256 "b8d79530e3b7c96a5ee2d1bd452889e169a0952c87e1f9cb1847cf0f9ef97984"
  license "Python-2.0"

  depends_on "pkgconf" => :build
  depends_on "bzip2"
  depends_on "expat"
  depends_on "gdbm"
  depends_on "libffi"
  depends_on "libxcrypt"
  depends_on "openssl@3"
  depends_on "sqlite"
  depends_on "xz"
  depends_on "zlib-ng-compat"

  def install
    ENV["PYTHONSTRICTEXTENSIONBUILD"] = "1"
    
    args = %W[
      --prefix=#{prefix}
      --enable-ipv6
      --datarootdir=#{share}
      --datadir=#{share}
      --enable-loadable-sqlite-extensions
      --with-openssl=#{Formula["openssl@3"].opt_prefix}
      --enable-optimizations
      --with-system-expat
      --with-system-libmpdec
      --with-readline=editline
      --with-zlib=#{Formula["zlib-ng-compat"].opt_prefix}
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end

  test do
    system bin/"python3.13", "-c", "print('Hello, World!')"
  end
end
