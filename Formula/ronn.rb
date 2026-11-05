class Ronn < Formula
  desc "Builds manuals - the opposite of roff"
  homepage "https://rtomayko.github.io/ronn/"
  url "https://github.com/rtomayko/ronn/archive/refs/tags/0.7.3.tar.gz"
  sha256 "808aa6668f636ce03abba99c53c2005cef559a5099f6b40bf2c7aad8e273acb4"
  license "MIT"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "179cd82f250572912c069f9dd17723c6efac924e12f5ddacc51b6f251402461a"
  end

  revision 5

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end


  uses_from_macos "ruby"

  conflicts_with "ronn-ng", because: "both install `ronn` binaries"

  # Fixes "undefined method 'has_rdoc=' for an instance of Gem::Specification"
  # Gemspec was last updated in 2010 and uses deprecated syntax
  # Accept the array `template_path` returned by mustache 1.1.3 and later
  patch :DATA

  resource "hpricot" do
    url "https://rubygems.org/downloads/hpricot-0.8.6.gem"
    sha256 "dfe8f4b3414ba8377d7626030f3aa605caadee9de87cffbeadf8a50359eac8ca"
  end

  def install
    ENV["GEM_HOME"] = libexec

    # hpricot 0.8.6 predates Ruby 4's strict callback prototypes. Patch its
    # rescue callback and pass the compatibility flag directly to extconf;
    # Homebrew's generic CFLAGS do not reach this nested gem installation.
    resource("hpricot").stage do
      system "gem", "unpack", "hpricot-0.8.6.gem"
      inreplace "hpricot-0.8.6/ext/fast_xs/fast_xs.c",
                "static VALUE unpack_uchar(VALUE self)\n{",
                "static VALUE unpack_uchar(VALUE self, VALUE exc)\n{\n\t(void)exc;"
      cd "hpricot-0.8.6" do
        system "ruby", "-rrubygems/package", "-e",
               's = Gem::Package.new("../hpricot-0.8.6.gem").spec; File.write("hpricot.gemspec", s.to_ruby)'
        system "gem", "build", "hpricot.gemspec"
        system "gem", "install", "--local", "--no-document", "hpricot-0.8.6.gem", "--",
               "--with-cflags=-Wno-error=incompatible-pointer-types"
      end
    end

    system "gem", "build", "ronn.gemspec"
    system "gem", "install", "ronn-#{version}.gem"
    bin.install libexec/"bin/ronn"
    bin.env_script_all_files(libexec/"bin", GEM_HOME: ENV["GEM_HOME"])
    man1.install "man/ronn.1"
    man7.install "man/ronn-format.7"
  end

  test do
    (testpath/"test.ronn").write <<~MARKDOWN
      simple(7) -- a simple ronn example
      ==================================

      This document is created by ronn.
    MARKDOWN
    system bin/"ronn", "--date", "1970-01-01", "test.ronn"
    rendered = shell_output("#{bin}/ronn --pipe --html --date 1970-01-01 test.ronn")
    assert_match "simple(7)", rendered
    assert_match "simple - a simple ronn example", rendered
    assert_match "This document is created by ronn.", rendered
    assert_match "January 1970", rendered
  end
end
__END__
diff --git a/ronn.gemspec b/ronn.gemspec
index 973a9b6..5708a9a 100644
--- a/ronn.gemspec
+++ b/ronn.gemspec
@@ -89,7 +89,6 @@ Gem::Specification.new do |s|
   s.add_dependency 'rdiscount',   '>= 1.5.8'
   s.add_dependency 'mustache',    '>= 0.7.0'

-  s.has_rdoc = true
   s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Ronn"]
   s.require_paths = %w[lib]
   s.rubygems_version = '1.1.1'
diff --git a/lib/ronn/template.rb b/lib/ronn/template.rb
--- a/lib/ronn/template.rb
+++ b/lib/ronn/template.rb
@@ -7,5 +7,5 @@ module Ronn
 
     def initialize(document, style_path=ENV['RONN_STYLE'].to_s.split(':'))
       @document = document
-      @style_path = style_path + [Template.template_path]
+      @style_path = style_path + Array(Template.template_path)
     end
