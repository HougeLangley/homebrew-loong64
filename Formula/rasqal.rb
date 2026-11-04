class Rasqal < Formula
  desc "RDF query library"
  homepage "https://librdf.org/rasqal/"
  url "https://download.librdf.org/source/rasqal-0.9.33.tar.gz"
  sha256 "6924c9ac6570bd241a9669f83b467c728a322470bf34f4b2da4f69492ccfd97c"
  license any_of: ["LGPL-2.1-or-later", "GPL-2.0-or-later", "Apache-2.0"]

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "989fc1121170aa6d45cb759c201ec4cb830d8295a226ecdf9c25426e4d387b47"
  end

  livecheck do
    url :homepage
    regex(/href=.*?rasqal[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  depends_on "pkgconf" => [:build, :test]
  depends_on "raptor"

  on_linux do
    depends_on "util-linux"
  end

  # Fix -flat_namespace being used on Big Sur and later.
  patch do
    file "Patches/libtool/configure-pre-0.4.2.418-big_sur.diff"
    type :unofficial
  end

  allow_network_access! :test

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--with-html-dir=#{share}/doc", *std_configure_args
    system "make", "install"
  end

  test do
    (testpath/"data.nt").write <<~EOS
      <http://example.org/bob> <http://xmlns.com/foaf/0.1/name> "Bob" .
      <http://example.org/alice> <http://xmlns.com/foaf/0.1/name> "Alice" .
    EOS

    query = "SELECT ?name WHERE { ?p <http://xmlns.com/foaf/0.1/name> ?name } ORDER BY ?name"
    output = shell_output("#{bin}/roqet -q -i sparql -r csv -F ntriples -D #{testpath}/data.nt -e '#{query}' 2>&1", 2)
    assert_equal "name\r\nAlice\r\nBob\r\n", output

    (testpath/"test.c").write <<~C
      #include <rasqal.h>

      int main(void) {
        rasqal_world *world = rasqal_new_world();
        if (!world || rasqal_world_open(world)) return 1;

        rasqal_query *query = rasqal_new_query(world, "sparql", NULL);
        if (!query) return 1;
        if (rasqal_query_prepare(query, (const unsigned char *)"SELECT ?s WHERE { ?s ?p ?o }", NULL)) return 1;

        rasqal_free_query(query);
        rasqal_free_world(world);
        return 0;
      }
    C

    pkgconf_flags = shell_output("pkgconf --cflags --libs rasqal").chomp.split
    system ENV.cc, "test.c", "-o", "test", *pkgconf_flags
    system "./test"
  end
end
