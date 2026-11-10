class Ctags < Formula
  desc "Reimplementation of ctags(1)"
  homepage "https://ctags.sourceforge.net/"
  license all_of: ["GPL-2.0-or-later", "LGPL-2.1-or-later"]
  revision 2

  stable do
    url "https://downloads.sourceforge.net/project/ctags/ctags/5.8/ctags-5.8.tar.gz"
    sha256 "0e44b45dcabe969e0bbbb11e30c246f81abe5d32012db37395eb57d66e9e99c7"

    # merged upstream but not yet in stable
    patch :p2 do
      url "https://gist.githubusercontent.com/naegelejd/9a0f3af61954ae5a77e7/raw/16d981a3d99628994ef0f73848b6beffc70b5db8/Ctags%20r782"
      sha256 "26d196a75fa73aae6a9041c1cb91aca2ad9d9c1de8192fce8cdc60e4aaadbcbb"
      type :backport
      resolves "https://sourceforge.net/p/ctags/bugs/312/"
    end

    # Use Debian patch to fix build with glibc 2.34+
    patch do
      on_linux do
        url "https://sources.debian.org/data/main/e/exuberant-ctags/1%3A5.9~svn20110310-18/debian/patches/use-conventional-unused-marker.patch"
        sha256 "65e92a8472e00386466888e441fd0f1223aabcf1d3812102f41fa34be003a668"
        type :unofficial
      end
    end
  end

  livecheck do
    url :stable
    regex(%r{url=.*?/ctags[._-]v?(\d+(?:\.\d+)+)\.t}i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "4a28a5131978a750e637aa3c4450fc14eda7adba27dffa4632bf2aea54f93797"
  end

  head do
    url "https://svn.code.sf.net/p/ctags/code/trunk"
    depends_on "autoconf" => :build
  end

  conflicts_with "universal-ctags", because: "both install `ctags` binaries"

  # fixes https://sourceforge.net/p/ctags/bugs/312/
  patch :p2 do
    on_macos do
      file "Patches/ctags/5.8.patch"
    end
  end

  deny_network_access!

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}", "dist/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    if build.head?
      system "autoheader"
      system "autoconf"
    end

    # Fix compile with newer Clang
    ENV.append_to_cflags "-Wno-implicit-function-declaration" if DevelopmentTools.clang_build_version >= 1200
    ENV.append_to_cflags "-Wno-implicit-int" if DevelopmentTools.clang_build_version >= 1403

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--prefix=#{prefix}",
                          "--enable-macro-patterns",
                          "--mandir=#{man}",
                          "--with-readlib"
    system "make", "install"
  end

  def caveats
    <<~EOS
      Under some circumstances, emacs and ctags can conflict. By default,
      emacs provides an executable `ctags` that would conflict with the
      executable of the same name that ctags provides. To prevent this,
      Homebrew removes the emacs `ctags` and its manpage before linking.
    EOS
  end

  test do
    (testpath/"test.c").write <<~C
      #include <stdio.h>
      #include <stdlib.h>

      void func()
      {
        printf("Hello World!");
      }

      int main()
      {
        func();
        return 0;
      }
    C
    system bin/"ctags", "-R", "."
    assert_match(/func.*test\.c/, File.read("tags"))
    assert_match "+regex", shell_output("#{bin}/ctags --version")
  end
end
