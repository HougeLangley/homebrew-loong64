class KyotoTycoon < Formula
  desc "Database server with interface to Kyoto Cabinet"
  homepage "https://dbmx.net/kyototycoon/"
  url "https://dbmx.net/kyototycoon/pkg/kyototycoon-0.9.56.tar.gz"
  sha256 "553e4ea83237d9153cc5e17881092cefe0b224687f7ebcc406b061b2f31c75c6"
  license "GPL-3.0-or-later"
  revision 5

  livecheck do
    url "https://dbmx.net/kyototycoon/pkg/"
    regex(/href=.*?kyototycoon[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "0d4db5aff6ba65ae92f0965bc9933cc4086cddb55e51d9d6eb196a592e78da98"
  end

  depends_on "lua" => :build
  depends_on "pkgconf" => :build
  depends_on "kyoto-cabinet"

  on_linux do
    depends_on "zlib-ng-compat"
  end

  # Build patch (submitted upstream)
  patch do
    file "Patches/kyoto-tycoon/0.9.56.patch"
  end

  # Homebrew-specific patch to support testing with ephemeral ports (submitted upstream)
  patch do
    file "Patches/kyoto-tycoon/ephemeral-ports.patch"
  end

  def install
    ENV.append_to_cflags "-fpermissive" if OS.linux?
    ENV.append "CXXFLAGS", "-std=c++98"
    system "./configure", "--prefix=#{prefix}",
                          "--with-kc=#{formula_opt_prefix("kyoto-cabinet")}",
                          "--with-lua=#{formula_opt_prefix("lua")}"
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.lua").write <<~LUA
      kt = __kyototycoon__
      db = kt.db
      -- echo back the input data as the output data
      function echo(inmap, outmap)
         for key, value in pairs(inmap) do
            outmap[key] = value
         end
         return kt.RVSUCCESS
      end
    LUA
    port = free_port

    spawn bin/"ktserver", "-port", port.to_s, "-scr", testpath/"test.lua"
    sleep 10

    assert_match "Homebrew\tCool", shell_output("#{bin}/ktremotemgr script -port #{port} echo Homebrew Cool 2>&1")
  end
end
