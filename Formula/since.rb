class Since < Formula
  desc "Stateful tail: show changes to files since last check"
  homepage "http://welz.org.za/projects/since"
  # Upstream is only available via HTTP, so we prefer Debian's HTTPS mirror
  url "https://deb.debian.org/debian/pool/main/s/since/since_1.1.orig.tar.gz"
  mirror "http://welz.org.za/projects/since/since-1.1.tar.gz"
  sha256 "739b7f161f8a045c1dff184e0fc319417c5e2deb3c7339d323d4065f7a3d0f45"
  license "GPL-3.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?since[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "63f3929de56afb270b7d91021841cd2b69ab0cce6b092ff3b674a9f8dee46c6a"
  end

  def install
    bin.mkpath
    man1.mkpath
    system "make", "install", "prefix=#{prefix}", "INSTALL=install"
  end

  test do
    (testpath/"test").write <<~EOS
      foo
      bar
    EOS
    system bin/"since", "-z", "test"
    assert_path_exists testpath/".since"
  end
end
