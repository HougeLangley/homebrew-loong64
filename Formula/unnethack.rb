class Unnethack < Formula
  desc "Fork of Nethack"
  homepage "https://unnethack.wordpress.com/"
  license "NGPL"

  stable do
    url "https://github.com/UnNetHack/UnNetHack/archive/refs/tags/5.3.2.tar.gz"
    sha256 "a32a2c0e758eb91842033d53d43f718f3bc719a346e993d9b23bac06f0ac9004"

    # Apply upstream commit to fix build with newer bison. Remove with next release.
    patch do
      url "https://github.com/UnNetHack/UnNetHack/commit/04f0a3a850a94eb8837ddcef31303968240d1c31.patch?full_index=1"
      sha256 "5285dc2e57b378bc77c01879399e2af248ef967977ed50e0c13a80b1993a7081"
      type :backport
    end

    # Fix implicit `ioctl` function declaration. Remove with the next release.
    patch do
      url "https://github.com/UnNetHack/UnNetHack/commit/33a3bb6539452875a88efbf6da0148a1cccc00c1.patch?full_index=1"
      sha256 "07e1bb472c4f20957dafc6cfc49fcfd3178a5e04fcebf93a4fc7922ec8c0a963"
      type :backport
    end
  end

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+(?:[._-]\d{6,8})?)$/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "e4e20b441c41154e0cf372300f90afa586943882f72746717d38567970b641be"
  end

  head do
    url "https://github.com/UnNetHack/UnNetHack.git", branch: "master"

    depends_on "lua"
  end

  uses_from_macos "bison" => :build
  uses_from_macos "flex" => :build
  uses_from_macos "ncurses"

  on_linux do
    depends_on "util-linux"
  end

  # directory for temporary level data of running games
  skip_clean "var/unnethack/level"

  deny_network_access!

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "buildaux/#{cf}", "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}", "dist/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    # Workaround for newer Clang. Fixed in HEAD but requires large patch
    # Ref: https://github.com/UnNetHack/UnNetHack/commit/00dd95ccad390e72d6a4fb2e058df48ed509b564
    ENV.append_to_cflags "-Wno-implicit-int" if DevelopmentTools.clang_build_version >= 1403
    # 1990s-style declarations in system.h are not valid C23 prototypes.
    ENV.append_to_cflags "-std=gnu17 -Wno-error=implicit-int -Wno-error=implicit-function-declaration" if OS.linux?

    ENV["LUA_INCLUDE"] = "-I#{formula_opt_include("lua")}/lua" if build.head?

    # directory for version specific files that shouldn't be deleted when
    # upgrading/uninstalling
    version_specific_directory = "#{var}/unnethack/#{version}"

    args = [
      "--with-owner=#{`id -un`}",
      # common xlogfile for all versions
      "--enable-xlogfile=#{var}/unnethack/xlogfile",
      "--with-bonesdir=#{version_specific_directory}/bones",
      "--with-savesdir=#{version_specific_directory}/saves",
      "--enable-wizmode=#{Utils.safe_popen_read("id", "-un")}",
    ]
    args << "--with-group=admin" if OS.mac?
    # Help old config scripts identify arm64 linux
    args << "--build=aarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arm64?
    args << "--build=loongarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arch == :loongarch64

    system "./configure", *args, *std_configure_args
    ENV.deparallelize # Race condition in make

    # disable the `chgrp` calls
    system "make", "install", "CHGRP=#"
  end

  test do
    assert_match "UnNetHack Version #{version}", shell_output("#{bin}/unnethack --version")

    # Reads the installed record file (prints "Cannot open record file!" if missing)
    output = shell_output("#{bin}/unnethack -s all")
    assert_match "Cannot find any current entries for all", output
    refute_match "Cannot open record file", output

    # The wrapper script installs the default config into $HOME
    assert_path_exists testpath/".unnethackrc"
  end
end
