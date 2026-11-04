class FuseZip < Formula
  desc "FUSE file system to create & manipulate ZIP archives"
  homepage "https://bitbucket.org/agalanin/fuse-zip"
  url "https://bitbucket.org/agalanin/fuse-zip/downloads/fuse-zip-0.7.2.tar.gz"
  sha256 "3dd0be005677442f1fd9769a02dfc0b4fcdd39eb167e5697db2f14f4fee58915"
  license "GPL-3.0-or-later"
  head "https://bitbucket.org/agalanin/fuse-zip.git", branch: "master"


  # Last release on 2021-01-31. Needs `libfuse@2` to build
  deprecate! date: "2026-06-21", because: :unmaintained
  disable! date: "2027-06-21", because: :unmaintained

  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "ce0e473b6e3bd75d795846a8c83089669561e071a817f6b0a54e15bce8be3dd7"
  end

  depends_on "pkgconf" => :build
  depends_on "libfuse@2"
  depends_on "libzip"
  depends_on :linux # on macOS, requires closed-source macFUSE

  def install
    system "make", "prefix=#{prefix}", "install"
  end

  test do
    system bin/"fuse-zip", "--help"
  end
end
