class Canfigger < Formula
  desc "Simple configuration file parser library"
  homepage "https://andy5995.github.io/canfigger/"
  url "https://github.com/andy5995/canfigger/releases/download/v0.3.2/canfigger-0.3.2.tar.xz"
  sha256 "f128a62cec50cce16e1e8c87012f8564d972b663316b27358d1d7f6b4486bec8"
  license "MIT"
  head "https://github.com/andy5995/canfigger.git", branch: "trunk"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "1a258db28f42174da32d9f1d50782c2dafe74bdb369a6f069124aee00c4996c7"
  end

  depends_on "meson" => :build
  depends_on "ninja" => :build

  deny_network_access!

  def install
    system "meson", "setup", "build", "-Dbuild_tests=false", "-Dbuild_examples=false", *std_meson_args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"
  end

  test do
    (testpath/"test.conf").write <<~EOS
      Numbers = list, one , two, three, four, five, six, seven
    EOS

    (testpath/"test.c").write <<~C
      #include <canfigger/canfigger.h>
      #include <stdio.h>

      int main()
      {
        char *file = "test.conf";
        struct Canfigger *config = canfigger_parse_file(file, ',');

        if (!config)
          return -1;

        while (config != NULL)
        {
          printf("Key: %s, Value: %s\\n", config->key,
                  config->value != NULL ? config->value : "NULL");

          char *attr = NULL;
          canfigger_free_current_attr_str_advance(config->attributes, &attr);
          while (attr)
          {
            printf("Attribute: %s\\n", attr);

            canfigger_free_current_attr_str_advance(config->attributes, &attr);
          }

          canfigger_free_current_key_node_advance(&config);
          putchar('\\n');
        }

        return 0;
      }
    C

    system ENV.cc, "test.c", "-L#{lib}", "-lcanfigger", "-o", "test"
    assert_match <<~EOS, shell_output("./test")
      Key: Numbers, Value: list
      Attribute: one
      Attribute: two
      Attribute: three
      Attribute: four
      Attribute: five
      Attribute: six
      Attribute: seven
    EOS
  end
end
