class Libdiscid < Formula
  desc "C library for creating MusicBrainz and freedb disc IDs"
  homepage "https://musicbrainz.org/doc/libdiscid"
  url "https://ftp.musicbrainz.org/pub/musicbrainz/libdiscid/libdiscid-0.7.0.tar.gz"
  sha256 "c230ed462c5ed7d7403ceb6984c57c8d05de42386d796bcd893636c0b0ba222f"
  license "LGPL-2.1-or-later"

  livecheck do
    url "https://ftp.musicbrainz.org/pub/musicbrainz/libdiscid/"
    regex(/href=.*?libdiscid[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "9a6d203b7a108b3e8c61f630a26206f1d714b205a4265422a85c7a5e20f9e274"
  end

  depends_on "pkgconf" => :test

  deny_network_access!

  def install
    system "./configure", *std_configure_args
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <stdio.h>
      #include <discid/discid.h>

      int main(void) {
        int offsets[] = {
          303602,
          150, 9700, 25887, 39297, 53795, 63735, 77517, 94877, 107270,
          123552, 135522, 148422, 161197, 174790, 192022, 205545,
          218010, 228700, 239590, 255470, 266932, 288750,
        };
        DiscId *d = discid_new();
        if (!discid_put(d, 1, 22, offsets)) return 1;
        printf("%s\\n", discid_get_id(d));
        discid_free(d);
        return 0;
      }
    C

    pkgconf_flags = shell_output("pkgconf --cflags --libs libdiscid").chomp.split
    system ENV.cc, "test.c", "-o", "test", *pkgconf_flags
    assert_equal "xUp1F2NkfP8s8jaeFn_Av3jNEI4-", shell_output("./test").strip
  end
end
