class LuaAT54 < Formula
  desc "Powerful, lightweight programming language"
  homepage "https://www.lua.org/"
  url "https://www.lua.org/ftp/lua-5.4.9.tar.gz"
  sha256 "2335b6c582a52654f94612bf10d2f4672805d05329aa6568b1d8cd9e5c6fb8e6"
  license "MIT"
  compatibility_version 1


  keg_only :versioned_formula

  # See: https://www.lua.org/versions.html#5.4
  # Last release on 2026-08-25
  deprecate! date: "2026-08-26", because: :unsupported
  disable! date: "2027-08-26", because: :unsupported

  on_linux do
    depends_on "readline"
  end

  # Be sure to build a dylib, or else runtime modules will pull in another static copy of liblua = crashy
  # See: https://github.com/Homebrew/legacy-homebrew/pull/5043
  patch do
    on_macos do
      file "Patches/lua/lua-dylib.patch"
    end

    # Add shared library for linux. Equivalent to the mac patch above.
    # Inspired from https://www.linuxfromscratch.org/blfs/view/cvs/general/lua.html
    on_linux do
      file "Patches/lua/lua-so.patch"
    end
  end

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "97b85410ce48f0529fbb907894d43c8bc0d3f56c84f5e07b6e06e823a541080b"
  end

  def install
    # Fix: /usr/bin/ld: lapi.o: relocation R_X86_64_32 against `luaO_nilobject_' can not be used
    # when making a shared object; recompile with -fPIC
    # See https://www.linuxfromscratch.org/blfs/view/cvs/general/lua.html
    ENV.append_to_cflags "-fPIC" if OS.linux?

    # Substitute formula prefix in `src/Makefile` for install name (dylib ID).
    # Use our CC/CFLAGS to compile.
    inreplace "src/Makefile" do |s|
      s.gsub! "@OPT_LIB@", opt_lib if OS.mac?
      s.remove_make_var! "CC"
      s.change_make_var! "MYCFLAGS", ENV.cflags || ""
      s.change_make_var! "MYLDFLAGS", ENV.ldflags || ""
    end

    # Fix path in the config header
    inreplace "src/luaconf.h", "/usr/local", HOMEBREW_PREFIX

    os = if OS.mac?
      "macosx"
    else
      "linux-readline"
    end

    system "make", os, "INSTALL_TOP=#{prefix}"
    system "make", "install", "INSTALL_TOP=#{prefix}"

    # We ship our own pkg-config file as Lua no longer provide them upstream.
    libs = %w[-llua -lm]
    libs << "-ldl" if OS.linux?
    (lib/"pkgconfig/lua.pc").write <<~PC
      V=#{version.major_minor}
      R=#{version}
      prefix=#{opt_prefix}
      INSTALL_BIN=${prefix}/bin
      INSTALL_INC=${prefix}/include/lua
      INSTALL_LIB=${prefix}/lib
      INSTALL_MAN=${prefix}/share/man/man1
      INSTALL_LMOD=${prefix}/share/lua/${V}
      INSTALL_CMOD=${prefix}/lib/lua/${V}
      exec_prefix=${prefix}
      libdir=${exec_prefix}/lib
      includedir=${prefix}/include/lua

      Name: Lua
      Description: An Extensible Extension Language
      Version: #{version}
      Requires:
      Libs: -L${libdir} #{libs.join(" ")}
      Cflags: -I${includedir}
    PC

    # Fix some software potentially hunting for different pc names.
    bin.install_symlink "lua" => "lua#{version.major_minor}"
    bin.install_symlink "lua" => "lua-#{version.major_minor}"
    bin.install_symlink "luac" => "luac#{version.major_minor}"
    bin.install_symlink "luac" => "luac-#{version.major_minor}"
    (include/"lua#{version.major_minor}").install_symlink Dir[include/"lua/*"]
    lib.install_symlink shared_library("liblua", version.major_minor.to_s) => shared_library("liblua#{version.major_minor}")
    (lib/"pkgconfig").install_symlink "lua.pc" => "lua#{version.major_minor}.pc"
    (lib/"pkgconfig").install_symlink "lua.pc" => "lua-#{version.major_minor}.pc"

    lib.install Dir[shared_library("src/liblua", "*")] if OS.linux?
  end

  def caveats
    <<~EOS
      You may also want luarocks:
        brew install luarocks
    EOS
  end

  test do
    assert_match "Homebrew is awesome!", shell_output("#{bin}/lua -e \"print ('Homebrew is awesome!')\"")
  end
end
