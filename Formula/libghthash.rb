class Libghthash < Formula
  desc "Generic hash table for C++"
  homepage "https://github.com/SimonKagstrom/libghthash"
  url "https://github.com/SimonKagstrom/libghthash/archive/refs/tags/v0.6.2.tar.gz"
  sha256 "e7e5f77df3e2a9152e0805f279ac048af9e572b83e60d29257cc754f8f9c22d6"
  license "LGPL-2.0-or-later"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "469613d56b7d880d5734c35e46f6dd07e4897837a78a5defdebf142c02bb2de7"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  def install
    system "autoreconf", "--force", "--install", "--verbose"
    system "./configure", "--disable-dependency-tracking",
           "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <string.h>
      #include <stdio.h>
      #include <stdlib.h>
      #include <ght_hash_table.h>

      int main(int argc, char *argv[])
      {
        ght_hash_table_t *p_table;
        int *p_data;
        int *p_he;
        int result;

        p_table = ght_create(128);

        if ( !(p_data = (int*)malloc(sizeof(int))) ) {
          return 1;
        }

        *p_data = 15;

        ght_insert(p_table,
             p_data,
             sizeof(char)*strlen("blabla"), "blabla");

        if ( (p_he = ght_get(p_table,
                 sizeof(char)*strlen("blabla"), "blabla")) ) {
          result = 0;
        } else {
          result = 1;
        }
        ght_finalize(p_table);

        return result;
      }
    C
    system ENV.cc, "test.c", "-L#{lib}", "-lghthash", "-o", "test"
    system "./test"
  end
end
