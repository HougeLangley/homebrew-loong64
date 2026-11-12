class Cgit < Formula
  desc "Hyperfast web frontend for Git repositories written in C"
  homepage "https://git.zx2c4.com/cgit/"
  # Using git checkout as snapshot archives have previously changed from server updates
  # https://github.com/Homebrew/homebrew-core/pull/290649#issuecomment-5654421778
  url "https://git.zx2c4.com/cgit.git",
      tag:      "v1.3.1",
      revision: "044821677c774cd24f25f1818ea51d09cc64b006"
  license "GPL-2.0-only"

  livecheck do
    url "https://git.zx2c4.com/cgit/refs/tags"
    regex(/href=.*?cgit[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "2bb8f82ca0c89d7272981535aa9f1bda400c70708144e55f3932e50b9387ee61"
  end

  on_macos do
    depends_on "gettext"
  end

  on_linux do
    depends_on "openssl@4" => :build # Uses CommonCrypto on macOS
    depends_on "zlib-ng-compat"
  end

  # cgit 1.2.2+ needs memrchr, for which macOS provides no implementation
  # https://lists.zx2c4.com/pipermail/cgit/2020-August/004510.html
  patch do
    file "Patches/cgit/memrchr-impl.patch"
  end


  def install
    system "make", "prefix=#{prefix}",
                   "CGIT_SCRIPT_PATH=#{pkgshare}",
                   "CGIT_DATA_PATH=#{var}/www/htdocs/cgit",
                   "CGIT_CONFIG=#{etc}/cgitrc",
                   "CACHE_ROOT=#{var}/cache/cgit",
                   "install"
  end

  test do
    (testpath/"cgitrc").write <<~EOS
      repo.url=test
      repo.path=#{testpath}
      repo.desc=the master foo repository
      repo.owner=fooman@example.com
    EOS

    ENV["CGIT_CONFIG"] = testpath/"cgitrc"
    # no "Status" line means 200
    refute_match(/Status: .+/, shell_output("#{pkgshare}/cgit.cgi"))
  end
end
