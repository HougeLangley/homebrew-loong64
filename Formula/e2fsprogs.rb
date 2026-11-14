class E2fsprogs < Formula
  desc "Utilities for the ext2, ext3, and ext4 file systems"
  homepage "https://e2fsprogs.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/e2fsprogs/e2fsprogs/v1.47.4/e2fsprogs-1.47.4.tar.gz"
  sha256 "2cec05f39c20ee621f14926195664e66e6017190ac8e4bbdb16d86082e43c5da"
  license all_of: [
    "GPL-2.0-or-later",
    "LGPL-2.0-or-later", # lib/ex2fs
    "LGPL-2.0-only",     # lib/e2p
    "BSD-3-Clause",      # lib/uuid
    "MIT",               # lib/et, lib/ss
  ]
  compatibility_version 1
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "bdb28f75a258b4efebcdb69e5e6c8a82e38ff0634b401b87fefe43eea1200f4a"
  end

  head "https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git", branch: "master"

  livecheck do
    url :stable
    regex(%r{url=.*?/e2fsprogs[._-]v?(\d+(?:\.\d+)+)\.t}i)
  end


  keg_only :shadowed_by_macos

  depends_on "pkgconf" => :build

  on_macos do
    depends_on "gettext"
  end

  on_linux do
    keg_only "it conflicts with the bundled copy in `krb5`"

    depends_on "util-linux"
  end

  deny_network_access!

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "buildaux/#{cf}", "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}", "dist/#{cf}"].each do |rel|
        src = "/usr/share/libtool/build-aux/#{cf}"
        dest = buildpath/rel
        if dest.exist? && File.exist?(src)
          File.chmod(0644, dest)
          cp src, dest
        end
      end
    end

    # Enforce MKDIR_P to work around a configure bug
    # see https://github.com/Homebrew/homebrew-core/pull/35339
    # and https://sourceforge.net/p/e2fsprogs/discussion/7053/thread/edec6de279/
    args = [
      "--prefix=#{prefix}",
      "--sysconfdir=#{etc}",
      "--disable-e2initrd-helper",
      "MKDIR_P=mkdir -p",
    ]
    args += if OS.linux?
      %w[
        --enable-elf-shlibs
        --disable-fsck
        --disable-uuidd
        --disable-libuuid
        --disable-libblkid
        --without-crond-dir
      ]
    else
      ["--enable-bsd-shlibs"]
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", *args

    system "make"

    # Fix: lib/libcom_err.1.1.dylib: No such file or directory
    ENV.deparallelize

    system "make", "install"
    system "make", "install-libs"
  end

  test do
    assert_equal 36, shell_output("#{bin}/uuidgen").strip.length if OS.mac?
    system bin/"lsattr", "-al"
  end
end
