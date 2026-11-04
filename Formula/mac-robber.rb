class MacRobber < Formula
  desc "Digital investigation tool"
  homepage "https://www.sleuthkit.org/mac-robber/"
  url "https://downloads.sourceforge.net/project/mac-robber/mac-robber/1.02/mac-robber-1.02.tar.gz"
  sha256 "5895d332ec8d87e15f21441c61545b7f68830a2ee2c967d381773bd08504806d"
  license "GPL-2.0-or-later"


  deny_network_access!

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "d7c8e8c6dde7d5e59fc6aedbf7c12577d7d3b931c1da224598e83f852b15ec20"
  end

  def install
    system "make", "CC=#{ENV.cc}", "GCC_OPT=#{ENV.cflags}"
    bin.install "mac-robber"
  end

  test do
    (testpath/"data").mkpath
    (testpath/"data/hello.txt").write "hello"
    chmod 0644, testpath/"data/hello.txt"
    (testpath/"data/link").make_symlink "hello.txt"

    output = shell_output("#{bin}/mac-robber data")
    assert_match "MD5|name|inode|mode_as_string|UID|GID|size|atime|mtime|ctime|crtime", output
    assert_match %r{^0\|data/hello\.txt\|0\|-rw-r--r--\|\d+\|\d+\|5\|}, output
    assert_match %r{^0\|data/link\|0\|l\S+ -> hello\.txt\|}, output

    assert_match "invalid directory: missing/", shell_output("#{bin}/mac-robber missing", 1)
  end
end
