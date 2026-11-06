class Redland < Formula
  desc "RDF Library"
  homepage "https://librdf.org/"
  url "https://download.librdf.org/source/redland-1.0.17.tar.gz"
  sha256 "de1847f7b59021c16bdc72abb4d8e2d9187cd6124d69156f3326dd34ee043681"
  license any_of: ["LGPL-2.1-or-later", "GPL-2.0-or-later", "Apache-2.0"]
  revision 1

  livecheck do
    url :homepage
    regex(/href=.*?redland[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "00a0b45dcac69a94337d3debeff22ff408d6554726fb2681b92d62dcb63157e1"
  end

  depends_on "pkgconf" => :build
  depends_on "libtool"
  depends_on "raptor"
  depends_on "rasqal"
  depends_on "sqlite"
  depends_on "unixodbc"

  resource "bindings" do
    url "https://download.librdf.org/source/redland-bindings-1.0.17.1.tar.gz"
    sha256 "ff72b587ab55f09daf81799cb3f9d263708fad5df7a5458f0c28566a2563b7f5"
  end

  # Fix -flat_namespace being used on Big Sur and later.
  patch do
    file "Patches/libtool/configure-pre-0.4.2.418-big_sur.diff"
    type :unofficial
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--with-bdb=no",
                          "--with-mysql=no",
                          "--with-sqlite=yes",
                          *std_configure_args
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <stdio.h>
      #include <redland.h>

      int main(int argc, char *argv[]) {
        librdf_world* world;
        librdf_storage* storage;
        librdf_model* model;
        librdf_statement *statement;

        world = librdf_new_world();
        librdf_world_open(world);
        storage = librdf_new_storage(world, "file", "file.rdf", NULL);
        model = librdf_new_model(world, storage, NULL);
        statement = librdf_new_statement_from_nodes(
          world,
          librdf_new_node_from_uri_string(world, (const unsigned char*) "https://example.org/"),
          librdf_new_node_from_uri_string(world, (const unsigned char*) "http://purl.org/dc/elements/1.1/title"),
          librdf_new_node_from_literal(world, (const unsigned char*) "Homebrew was here", NULL, 0)
        );

        librdf_model_add_statement(model, statement);
        librdf_free_statement(statement);
        librdf_free_model(model);
        librdf_free_storage(storage);
        librdf_free_world(world);

        return 0;
      }
    C

    (testpath/"file.rdf").write <<~XML
      <?xml version="1.0"?>
      <rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
          xmlns:dc="http://purl.org/dc/elements/1.1/">
        <rdf:Description rdf:about="https://example.org">
          <dc:title>Example Site</dc:title>
          <dc:creator>Internet Assigned Numbers Authority</dc:creator>
          <dc:description>
            This domain is for use in illustrative examples in documents.
            You may use this domain in literature without prior coordination or asking for permission.
          </dc:description>
        </rdf:Description>
      </rdf:RDF>
    XML

    includes = %W[
      -I#{include}
      -I#{formula_opt_include("raptor")}/raptor2
      -I#{formula_opt_include("rasqal")}/rasqal
    ]

    libs = %W[
      -L#{lib}
      -L#{formula_opt_lib("raptor")}
      -L#{formula_opt_lib("rasqal")}
      -lrdf -lraptor2 -lrasqal
    ]

    system ENV.cc, *includes, "test.c", *libs, "-o", "test"
    system testpath/"test"

    expected = <<~EOS
      #{" " * 2}<rdf:Description rdf:about="https://example.org/">
      #{" " * 4}<ns0:title xmlns:ns0="http://purl.org/dc/elements/1.1/">Homebrew was here</ns0:title>
      #{" " * 2}</rdf:Description>
    EOS
    assert_match expected, (testpath/"file.rdf").read
  end
end
