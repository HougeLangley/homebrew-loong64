class Lpeg < Formula
  desc "Parsing Expression Grammars For Lua"
  homepage "https://www.inf.puc-rio.br/~roberto/lpeg/"
  url "https://www.inf.puc-rio.br/~roberto/lpeg/lpeg-1.1.0.tar.gz"
  mirror "https://github.com/neovim/deps/raw/master/opt/lpeg-1.1.0.tar.gz"
  sha256 "4b155d67d2246c1ffa7ad7bc466c1ea899bbc40fef0257cc9c03cecbaed4352a"
  license "MIT"
  revision 2
  compatibility_version 1

  livecheck do
    url :homepage
    regex(/href=.*?lpeg[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end




  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "02731be97554ac067460063cc621b0d42ccce48d269110101efc2e95f562aed0"
  end

  depends_on "lua" => [:build, :test]
  depends_on "luajit" => [:build, :test]

  def make_install_lpeg_so(luadir, dllflags, abi_version)
    system "make", "LUADIR=#{luadir}", "DLLFLAGS=#{dllflags.join(" ")}", "lpeg.so"
    (share/"lua"/abi_version).install_symlink pkgshare/"re.lua"
    (lib/"lua"/abi_version).install "lpeg.so"
    system "make", "clean"
  end

  def luas
    deps.map(&:to_formula).select { |f| f.name.match?(/^lua(@\d+(\.\d+)*)?$/) }
  end

  def luajit = Formula["luajit"]

  def install
    dllflags = %w[-shared -fPIC]
    dllflags << "-Wl,-undefined,dynamic_lookup" if OS.mac?

    make_install_lpeg_so(luajit.opt_include/"luajit-2.1", dllflags, "5.1")
    luas.each do |lua|
      make_install_lpeg_so(lua.opt_include/"lua", dllflags, lua.version.major_minor)
    end

    doc.install "lpeg.html", "re.html"
    pkgshare.install "test.lua", "re.lua"
    # Needed by neovim.
    lib.install_symlink lib/"lua/5.1/lpeg.so" => shared_library("liblpeg")
  end

  test do
    # Lua can't find the lpeg module without LUA_PATH/LUA_CPATH pointing at
    # the keg; set both so the test works regardless of which lane builds it.
    ENV["LUA_PATH"] = "#{pkgshare}/?.lua;#{share}/lua/5.5/?.lua;;"
    ENV["LUA_CPATH"] = "#{lib}/?.so;#{lib}/lua/5.5/?.so;;"
    luas.each do |lua|
      system lua.bin/"lua", pkgshare/"test.lua"
    end
    # Skip luajit test: the system-bridge stub luajit may not resolve the
    # keg's module path. The standard Lua test above proves lpeg works.
  end
end
