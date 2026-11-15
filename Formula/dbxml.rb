class Dbxml < Formula
  desc "Embeddable XML database with XQuery support and other advanced features"
  homepage "https://www.oracle.com/database/technologies/related/berkeleydb.html"
  url "https://download.oracle.com/berkeley-db/dbxml-6.1.4.tar.gz"
  sha256 "a8fc8f5e0c3b6e42741fa4dfc3b878c982ff8f5e5f14843f6a7e20d22e64251a"
  license "AGPL-3.0-only"
  revision 4


  deprecate! date: "2026-04-18", because: :unmaintained
  disable! date: "2027-04-18", because: :unmaintained


  depends_on "berkeley-db"
  depends_on "xerces-c"
  depends_on "xqilla"

  on_linux do
    depends_on "zlib-ng-compat"
  end

  # No public bug tracker or mailing list to submit this to, unfortunately.
  patch do
    file "Patches/dbxml/cxx11.patch"
    type :unofficial
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "buildaux/#{cf}", "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}", "dist/#{cf}"].each do |rel|
        src = "/usr/share/libtool/build-aux/#{cf}"
        dest = buildpath/rel
        if dest.exist? && File.exist?(src)
          File.chmod(0644, dest)
          cp src, dest
        end
      end
    end

    ENV.cxx11

    inreplace "dbxml/configure" do |s|
      s.gsub! %r{=`ls ("\$with_berkeleydb"/lib)/libdb-\*\.la \| sed -e 's/\.\*db-\\\(\.\*\\\)\.la/},
              "=`find \\1 -name #{shared_library("libdb-*")} -maxdepth 1 ! -type l " \
              "| sed -e 's/#{shared_library(".*db-\\(.*\\)")}/"
      s.gsub! "lib/libdb-*.la", "lib/#{shared_library("libdb-*")}"
      s.gsub! "libz.a", shared_library("libz")
    end

    args = %W[
      --with-xqilla=#{formula_opt_prefix("xqilla")}
      --with-xerces=#{formula_opt_prefix("xerces-c")}
      --with-berkeleydb=#{formula_opt_prefix("berkeley-db")}
    ]
    args << "--with-zlib=#{formula_opt_prefix("zlib-ng-compat")}" unless OS.mac?
    # Help old config scripts identify arm64 linux
    args << "--build=aarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arm64?
    args << "--build=loongarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arch == :loongarch64

    cd "dbxml" do
      system "./configure", *std_configure_args, *args
      system "make", "install"
    end
  end

  test do
    (testpath/"simple.xml").write <<~XML
      <breakfast_menu>
        <food>
          <name>Belgian Waffles</name>
          <calories>650</calories>
        </food>
        <food>
          <name>Homestyle Breakfast</name>
          <calories>950</calories>
        </food>
      </breakfast_menu>
    XML

    (testpath/"dbxml.script").write <<~EOS
      createContainer ""
      putDocument simple "simple.xml" f
      cquery 'sum(//food/calories)'
      print
      quit
    EOS
    assert_equal "1600", shell_output("#{bin}/dbxml -s #{testpath}/dbxml.script").chomp
  end
end
