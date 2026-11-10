class BerkeleyDb < Formula
  desc "High performance key/value database"
  homepage "https://www.oracle.com/database/technologies/related/berkeleydb.html"
  url "https://download.oracle.com/berkeley-db/db-18.1.40.tar.gz"
  mirror "https://fossies.org/linux/misc/db-18.1.40.tar.gz"
  sha256 "0cecb2ef0c67b166de93732769abdeba0555086d51de1090df325e18ee8da9c8"
  license "AGPL-3.0-only"
  revision 4

  livecheck do
    url "https://www.oracle.com/database/technologies/related/berkeleydb-downloads.html"
    regex(%r{/berkeleydb/html/changelog[._-]v?(\d+(?:[._]\d+)+)\.html?}i)
    strategy :page_match do |page, regex|
      page.scan(regex).map { |match| match[0].tr("_", ".") }
    end
  end


  keg_only :provided_by_macos

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "2f62e153a11f1a54b569cb16645e78c656ad9fa15dd50f618167fb4f08fc849e"
  end

  depends_on "openssl@4"

  # Fix -flat_namespace being used on Big Sur and later.
  patch do
    file "Patches/libtool/configure-pre-0.4.2.418-big_sur.diff"
    directory "dist"
    type :unofficial
  end

  def install
    # LoongArch triplet and GCC 16 compatibility without overriding Berkeley's
    # Makefile CFLAGS (which carry its required include paths).
    ENV.append_to_cflags "-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types"
    %w[config.sub config.guess].each do |cf|
      src = "/usr/share/libtool/build-aux/#{cf}"
      cp src, "dist/#{cf}" if File.exist?(src)
    end

    # Work around undefined NULL causing incorrect detection of thread local storage class
    ENV.append "CFLAGS", "-include stddef.h" if DevelopmentTools.clang_build_version >= 1500

    # BerkeleyDB dislikes parallel builds
    ENV.deparallelize

    # --enable-compat185 is necessary because our build shadows
    # the system berkeley db 1.x
    args = %W[
      --disable-debug
      --disable-static
      --prefix=#{prefix}
      --mandir=#{man}
      --enable-cxx
      --enable-compat185
      --enable-sql
      --enable-sql_codegen
      --enable-dbm
      --enable-stl
    ]

    # BerkeleyDB requires you to build everything from the build_unix subdirectory
    cd "build_unix" do
      args << "--build=loongarch64-unknown-linux-gnu"
      system "../dist/configure", *args
      system "make", "install", "DOCLIST=license"

      # delete docs dir because it is huge
      rm_r(prefix/"docs")
    end
  end

  test do
    (testpath/"test.cpp").write <<~CPP
      #include <assert.h>
      #include <string.h>
      #include <db_cxx.h>
      int main() {
        Db db(NULL, 0);
        assert(db.open(NULL, "test.db", NULL, DB_BTREE, DB_CREATE, 0) == 0);

        const char *project = "Homebrew";
        const char *stored_description = "The missing package manager for macOS";
        Dbt key(const_cast<char *>(project), strlen(project) + 1);
        Dbt stored_data(const_cast<char *>(stored_description), strlen(stored_description) + 1);
        assert(db.put(NULL, &key, &stored_data, DB_NOOVERWRITE) == 0);

        Dbt returned_data;
        assert(db.get(NULL, &key, &returned_data, 0) == 0);
        assert(strcmp(stored_description, (const char *)(returned_data.get_data())) == 0);

        assert(db.close(0) == 0);
      }
    CPP
    flags = %W[
      -I#{include}
      -L#{lib}
      -ldb_cxx
    ]
    system ENV.cxx, "test.cpp", "-o", "test", *flags
    system "./test"
    assert_path_exists testpath/"test.db"
  end
end
