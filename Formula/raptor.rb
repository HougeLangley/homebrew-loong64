class Raptor < Formula
  desc "RDF parser toolkit"
  homepage "https://librdf.org/raptor/"
  url "https://download.librdf.org/source/raptor2-2.0.16.tar.gz"
  sha256 "089db78d7ac982354bdbf39d973baf09581e6904ac4c92a98c5caadb3de44680"
  license any_of: ["LGPL-2.1-or-later", "GPL-2.0-or-later", "Apache-2.0"]
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "c2c9c49cf201a9d4fc57481b61145a415344e08d31fa9157752b70eecc92e4b3"
  end

  revision 1
  compatibility_version 1

  livecheck do
    url :homepage
    regex(/href=.*?raptor2[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  uses_from_macos "curl"
  uses_from_macos "libxml2"

  # Fix compilation with libxml2 2.11.0 or later. Patch is already applied upstream, remove on next release.
  patch do
    url "https://github.com/dajobe/raptor/commit/ac914399b9013c54572833d4818e6ce008136dc9.patch?full_index=1"
    sha256 "d527fb9ad94f22acafcec9f3b626fb876b7fb1b722e6999cf46a158172bb0992"
    type :backport
    resolves "https://github.com/dajobe/raptor/pull/58"
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", *std_configure_args
    system "make", "install"
  end

  test do
    test_url = "https://raw.githubusercontent.com/dajobe/raptor/" \
               "b5e91dfdf7e1ea5ca5a5f7b48c428dd3da1219e0/tests/feeds/test01.rdf"
    output = shell_output("#{bin}/rapper --output ntriples #{test_url}")
    assert_match '_:genid2 <http://purl.org/dc/elements/1.1/title> "Example"', output
  end
end
