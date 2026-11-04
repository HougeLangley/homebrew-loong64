class Girara < Formula
  desc "Common components for zathura"
  homepage "https://pwmt.org/projects/girara/"
  url "https://pwmt.org/projects/girara/download/girara-2026.07.18.tar.xz"
  sha256 "d7255635776a45d42d1e555aa425ab96caf23755442474cf240cbac966d8502f"
  license "Zlib"

  livecheck do
    url "https://pwmt.org/projects/girara/download/"
    regex(/girara[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "ab99f77ed3d0d817ef43fb8831fbef4fe8bad4f537790467bb4c8d853a574519"
  end

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkgconf" => [:build, :test]

  depends_on "glib"

  def install
    # Upstream defaults to c_std=c23, which GCC 13 (CI) rejects; c17 is equivalent here.
    system "meson", "setup", "build", "-Ddocs=disabled", "-Dc_std=c17", *std_meson_args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <stdio.h>
      #include <girara/girara.h>

      int main(void) {
        GiraraTemplate* obj = girara_template_new("home@test@");
        girara_template_add_variable(obj, "test");
        girara_template_set_variable_value(obj, "test", "brew");
        char* result = girara_template_evaluate(obj);
        g_object_unref(obj);
        if (result == NULL) return 1;
        printf("%s", result);
        g_free(result);
        return 0;
      }
    C

    system ENV.cc, "test.c", "-o", "test", *shell_output("pkgconf --cflags --libs girara").chomp.split
    assert_equal "homebrew", shell_output("./test")
  end
end
