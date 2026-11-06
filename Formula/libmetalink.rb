class Libmetalink < Formula
  desc "C library to parse Metalink XML files"
  homepage "https://launchpad.net/libmetalink/"
  url "https://launchpad.net/libmetalink/trunk/libmetalink-0.1.3/+download/libmetalink-0.1.3.tar.xz"
  sha256 "86312620c5b64c694b91f9cc355eabbd358fa92195b3e99517504076bf9fe33a"
  license "MIT"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "603efccb78b984f46ed414882a1e129e87d79c52fe5132df95ab7259b892c255"
  end

  livecheck do
    url :stable
    regex(%r{<div class="version">\s*Latest version is libmetalink[._-]v?(\d+(?:\.\d+)+)\s*</div>}i)
  end


  depends_on "pkgconf" => [:build, :test]

  uses_from_macos "expat"

  deny_network_access!

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
    (testpath/"test.meta4").write <<~XML
      <?xml version="1.0" encoding="UTF-8"?>
      <metalink xmlns="urn:ietf:params:xml:ns:metalink">
        <file name="example.tar.gz">
          <url>https://example.com/example.tar.gz</url>
        </file>
      </metalink>
    XML

    (testpath/"test.c").write <<~C
      #include <stdio.h>
      #include <metalink/metalink.h>

      int main(void) {
        metalink_t *metalink;
        if (metalink_parse_file("test.meta4", &metalink) != 0) return 1;
        printf("%s\\n", metalink->files[0]->name);
        metalink_delete(metalink);
        return 0;
      }
    C

    pkgconf_flags = shell_output("pkgconf --cflags --libs libmetalink").chomp.split
    system ENV.cc, "test.c", "-o", "test", *pkgconf_flags
    assert_equal "example.tar.gz", shell_output("./test").strip
  end
end
