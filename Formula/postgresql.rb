class Postgresql < Formula
  desc "Object-relational database system"
  homepage "https://www.postgresql.org/"
  url "https://ftp.postgresql.org/pub/source/v17.4/postgresql-17.4.tar.bz2"
  sha256 "c4605b73fea1196340aa359c5026d4d8d454f520e286b8082cb5f4e5e1569cc1"
  license "PostgreSQL"

  depends_on "gettext"
  depends_on "icu4c"
  depends_on "openssl@3"
  depends_on "readline"
  depends_on "zlib-ng-compat"

  def install
    ENV.prepend "LDFLAGS", "-L#{Formula["openssl@3"].opt_lib} -L#{Formula["readline"].opt_lib}"
    ENV.prepend "CPPFLAGS", "-I#{Formula["openssl@3"].opt_include} -I#{Formula["readline"].opt_include}"

    args = %W[
      --prefix=#{prefix}
      --with-openssl
      --with-libxml
      --with-libxslt
      --with-icu
      --enable-nls
      --with-zlib
    ]

    system "./configure", *args
    system "make"
    system "make", "install-world"
  end

  test do
    system bin/"initdb", "--version"
  end
end
