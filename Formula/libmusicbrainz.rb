class Libmusicbrainz < Formula
  desc "MusicBrainz Client Library"
  homepage "https://musicbrainz.org/doc/libmusicbrainz"
  url "https://github.com/metabrainz/libmusicbrainz/releases/download/release-5.1.0/libmusicbrainz-5.1.0.tar.gz"
  sha256 "6749259e89bbb273f3f5ad7acdffb7c47a2cf8fcaeab4c4695484cef5f4c6b46"
  license "LGPL-2.1-or-later"
  revision 1


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "de7989cd47da67f5e0ea48ec64b9f77ee9f6883eafb2cbc016ea17e9d87e42b3"
  end

  depends_on "cmake" => :build
  depends_on "pkgconf" => [:build, :test]
  depends_on "neon"

  uses_from_macos "libxml2"

  # Backport fix to build with newer libxml2
  patch do
    url "https://github.com/metabrainz/libmusicbrainz/commit/4655b571a70d73d41467091f59c518517c956198.patch?full_index=1"
    sha256 "ee0c63e56a17156bca13b157744a54aeed6e19b39f65b14f2a5ac4e504358c8e"
    type :backport
    resolves "https://github.com/metabrainz/libmusicbrainz/pull/19"
  end

  # cmake: Set minimum required version to 3.5 for CMake 4+
  patch do
    url "https://github.com/metabrainz/libmusicbrainz/commit/9d216e08aadf436dd166876d566efe033510adc6.patch?full_index=1"
    sha256 "2074078fabd6920ec085df06d1fd28a3eced86176788e17f3ea67a1d40d1189d"
    type :backport
    resolves "https://github.com/metabrainz/libmusicbrainz/pull/21"
  end

  deny_network_access!

  def install
    system "cmake", "-S", ".", "-B", ".", *std_cmake_args
    system "cmake", "--build", "."
    system "cmake", "--install", "."
  end

  test do
    (testpath/"test.cpp").write <<~CPP
      #include <iostream>
      #include <musicbrainz5/Metadata.h>
      #include <musicbrainz5/Artist.h>

      int main() {
        const std::string xml =
          "<metadata xmlns=\\"http://musicbrainz.org/ns/mmd-2.0#\\">"
          "<artist><name>Radiohead</name></artist></metadata>";

        XMLResults results;
        XMLNode *root = XMLRootNode::parseString(xml, &results);
        if (results.code != eXMLErrorNone) return 1;

        MusicBrainz5::CMetadata metadata(*root);
        delete root;
        if (!metadata.Artist()) return 1;
        std::cout << metadata.Artist()->Name() << std::endl;
        return 0;
      }
    CPP

    pkgconf_flags = shell_output("pkgconf --cflags --libs libmusicbrainz5").chomp.split
    system ENV.cxx, "-std=c++11", "test.cpp", "-o", "test", *pkgconf_flags
    assert_equal "Radiohead", shell_output("./test").strip
  end
end
