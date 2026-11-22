class VampPluginSdk < Formula
  desc "Audio processing plugin system sdk"
  homepage "https://www.vamp-plugins.org/"
  url "https://github.com/vamp-plugins/vamp-plugin-sdk/releases/download/vamp-plugin-sdk-v2.10/vamp-plugin-sdk-2.10.0.tar.gz"
  sha256 "aeaf3762a44b148cebb10cde82f577317ffc9df2720e5445c3df85f3739ff75f"
  license all_of: ["X11", "BSD-3-Clause"]
  revision 1
  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "d0f39d867afd36b7411ebf72b8d6886ca17f8dc4be47a0bf04da41e0b748a343"
  end

  head "https://github.com/vamp-plugins/vamp-plugin-sdk.git", branch: "master"

  livecheck do
    url :stable
    regex(/^vamp-plugin-sdk[._-]v?(\d+(?:\.\d+)+)\.t/i)
    strategy :github_latest do |json, regex|
      json["assets"]&.map do |asset|
        match = asset["name"]&.match(regex)
        next if match.blank?

        match[1]
      end
    end
  end



  depends_on "automake" => :build
  depends_on "pkgconf" => :build
  depends_on "flac"
  depends_on "libogg"
  depends_on "libsndfile"

  def install
    system "./configure", *std_configure_args
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~CPP
      #include "vamp-sdk/Plugin.h"
      #include <vamp-sdk/PluginAdapter.h>

      class MyPlugin : public Vamp::Plugin { };

      const VampPluginDescriptor *
      vampGetPluginDescriptor(unsigned int version, unsigned int index) { return NULL; }
    CPP

    flags = if OS.mac?
      ["-Wl,-dylib"]
    else
      ["-shared", "-fPIC"]
    end

    system ENV.cxx, "test.cpp", "-I#{include}", *flags, "-o", shared_library("test")
    assert_match "Usage:", shell_output("#{bin}/vamp-rdf-template-generator 2>&1", 2)

    cp "#{lib}/vamp/vamp-example-plugins.so", testpath/shared_library("vamp-example-plugins")
    ENV["VAMP_PATH"]=testpath
    assert_match "amplitudefollower", shell_output("#{bin}/vamp-simple-host -l")
  end
end
