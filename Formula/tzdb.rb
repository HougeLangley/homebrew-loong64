class Tzdb < Formula
  desc "Time Zone Database"
  homepage "https://www.iana.org/time-zones"
  url "https://data.iana.org/time-zones/releases/tzdb-2026e.tar.lz"
  sha256 "4e9c4e9d4587443e716ed42a7070466c1e5975938fb530244a17cf6db883990b"
  license all_of: ["BSD-3-Clause", :public_domain]

  livecheck do
    url "https://ftp.iana.org/tz/releases/"
    regex(/href=.*?tzdb[._-]v?(\d+(?:\.\d+)*[a-z]?)\.t/i)
  end


  on_macos do
    depends_on "gettext"
  end

  def localtime
    etc/"localtime"
  end

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "57f8cd59705834c67d92c0650a10e2c1d6cdb0dae5c8a38f37efcde220cac3d8"
  end

  def install
    make_args = %W[
      CFLAGS=#{ENV.cflags}
      USRDIR=#{prefix}
      TZDEFAULT=#{localtime}
    ]
    make_args << "LDLIBS=-lintl" if OS.mac?

    system "make", *make_args, "install"
  end

  post_install_steps do
    run "zic", args: ["-l", "Factory", "-p", "-", "-t", "{{etc}}/localtime"], base: :sbin
  end

  test do
    assert_match "UTC", shell_output("#{bin}/zdump UTC")
  end
end
