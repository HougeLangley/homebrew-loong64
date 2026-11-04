class Libeatmydata < Formula
  desc "LD_PRELOAD library and wrapper to transparently disable fsync and related calls"
  homepage "https://www.flamingspork.com/projects/libeatmydata/"
  license "GPL-3.0-or-later"
  head "https://github.com/stewartsmith/libeatmydata.git", branch: "master"

  stable do
    url "https://github.com/stewartsmith/libeatmydata/releases/download/v131/libeatmydata-131.tar.gz"
    sha256 "cf18a8c52138a38541be3478af446c06048108729d7e18476492d62d54baabc4"

    # Fix for https://github.com/Homebrew/homebrew-core/issues/136873.
    # Remove with `stable`` block on next release.
    patch do
      url "https://github.com/stewartsmith/libeatmydata/commit/ae89d0916c0ddd06f4ce7f2b37eaccf8dd543591.patch?full_index=1"
      sha256 "8bf4249f3df141fa321c8c64af4f4442bc23bdfb108e2cf73c22e68a3a71ae15"
      type :backport
      resolves "https://github.com/stewartsmith/libeatmydata/pull/33"
    end
  end


  bottle do
    rebuild 3
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "3f4cce6f452157ac1781f43a92be6513ccee1db8914b3fd384f8c3f810f8d40a"
  end

  depends_on "autoconf" => :build
  depends_on "autoconf-archive" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  on_monterey :or_older do
    depends_on "coreutils"
  end

  on_linux do
    depends_on "strace" => :test
  end

  def install
    # macOS before 12.3 does not support `readlink -f` as used by the `eatmydata` shell wrapper script
    if OS.mac? && MacOS.version <= :monterey
      inreplace "eatmydata.sh.in", "readlink", "#{formula_opt_bin("coreutils")}/greadlink"
    end

    system "autoreconf", "--force", "--install", "--verbose"
    system "./configure", "--disable-option-checking",
                          "--disable-silent-rules",
                          *std_configure_args
    system "make", "install"
  end

  test do
    system bin/"eatmydata", "sync"
    return if OS.mac?

    output = shell_output("#{bin}/eatmydata #{formula_opt_bin("strace")}/strace sync 2>&1")
    refute_match(/^[a-z]*sync/, output)
    refute_match("O_SYNC", output)
    assert_match(" exited with 0 ", output)
  end
end
