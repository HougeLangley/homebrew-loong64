class Libvisual < Formula
  desc "Audio Visualization tool and library"
  homepage "https://github.com/Libvisual/libvisual"
  url "https://github.com/Libvisual/libvisual/releases/download/libvisual-0.4.2/libvisual-0.4.2.tar.gz"
  sha256 "63085fd9835c42c9399ea6bb13a7ebd4b1547ace75c4595ce8e9759512bd998a"
  license all_of: ["GPL-2.0-or-later", "LGPL-2.1-or-later"]



  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "3dd67426b985016e08afd48a696a6b8a9fbfe1086ad3846760ab5074372f65a2"
  end

  depends_on "pkgconf" => :build
  depends_on "sdl12-compat" # SDL 2 issue: https://github.com/Libvisual/libvisual/issues/193

  def install
    # NOTE: Other formulae would not be able to install to libvisual's cellar
    #       so we rely on brew's auto-symlinking to
    #       <HOMEBREW_PREFIX>/lib/libvisual-<major>.<minor> .
    #       See libvisual-plugins.rb and/or libvisual-projectm.rb
    #       for how this is used by a formula installing libvisual plug-ins.
    inreplace "configure",
      "LIBVISUAL_PLUGINS_BASE_DIR=\"${libdir}/libvisual-${LIBVISUAL_VERSION_SUFFIX}\"",
      "LIBVISUAL_PLUGINS_BASE_DIR=\"#{HOMEBREW_PREFIX}/lib/libvisual-#{version.major_minor}\""

    system "./configure", *std_configure_args
    system "make"
    system "make", "install"
  end

  test do
    # `lv-tool` starts through SDL 1.2's Cocoa `SDLmain`, which never finishes launching in the test sandbox
    (testpath/"test.c").write <<~C
      #include <stdio.h>
      #include <libvisual/libvisual.h>

      int main(int argc, char **argv) {
        visual_init(&argc, &argv);
        puts(visual_get_version());
        visual_quit();
        return 0;
      }
    C
    system ENV.cc, "test.c", "-o", "test", "-I#{include}/libvisual-#{version.major_minor}",
                   "-L#{lib}", "-lvisual-#{version.major_minor}"
    assert_equal version.to_s, shell_output("./test").strip
  end
end
