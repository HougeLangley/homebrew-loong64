class Mysqlxx < Formula
  desc "C++ wrapper for MySQL's C API"
  homepage "https://tangentsoft.com/mysqlpp/home"
  url "https://tangentsoft.com/mysqlpp/releases/mysql++-3.3.0.tar.gz"
  sha256 "449cbc46556cc2cc9f9d6736904169a8df6415f6960528ee658998f96ca0e7cf"
  license "LGPL-2.1-or-later"
  revision 4

  livecheck do
    url "https://tangentsoft.com/mysqlpp/releases/"
    regex(/>mysql\+\+[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "46eff9a919c3db1caf1c1c1b4f7c307f2fbf808276f7045796acda7f218499c0"
  end

  depends_on "mariadb-connector-c"

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    mariadb = Formula["mariadb-connector-c"]
    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--with-field-limit=40",
                          "--with-mysql=#{mariadb.opt_prefix}",
                          *std_configure_args

    # Delete "version" file incorrectly included as C++20 <version> header
    # Issue ref: https://tangentsoft.com/mysqlpp/tktview/4ea874fe67e39eb13ed4b41df0c591d26ef0a26c
    # Remove when fixed upstream
    rm "version"

    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~CPP
      #include <mysql++/cmdline.h>
      int main(int argc, char *argv[]) {
        mysqlpp::examples::CommandLine cmdline(argc, argv);
        if (!cmdline) {
          return 1;
        }
        return 0;
      }
    CPP
    system ENV.cxx, "test.cpp", "-I#{formula_opt_include("mariadb-connector-c")}/mariadb",
                    "-L#{lib}", "-lmysqlpp", "-o", "test"
    system "./test", "-u", "foo", "-p", "bar"
  end
end
