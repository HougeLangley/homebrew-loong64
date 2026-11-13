class Unifdef < Formula
  desc "Selectively process conditional C preprocessor directives"
  homepage "https://dotat.at/prog/unifdef/"
  url "https://dotat.at/prog/unifdef/unifdef-2.12.tar.gz"
  sha256 "fba564a24db7b97ebe9329713ac970627b902e5e9e8b14e19e024eb6e278d10b"
  license all_of: [
    "BSD-2-Clause",
    "BSD-3-Clause", # only for `unifdef.1`
  ]
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "5c3087288ac0d5b61a1733d4e5d6d93566ff7187741c6bf7d65506779778dedd"
  end

  head "https://github.com/fanf2/unifdef.git", branch: "master"


  keg_only :provided_by_macos

  # AOSC OS / upstream PR 19: C23 made constexpr a keyword.
  patch do
    url "https://raw.githubusercontent.com/AOSC-Dev/aosc-os-abbs/1455c7aba657718f19fa5c3488923606b67a03ad/app-devel/unifdef/autobuild/patches/0001-FROMLIST-Don-t-use-C23-constexpr-keyword.patch"
    sha256 "3729cbe6d60dce80aa37d413d5ac23648935f91b56a5547e91a2ab8f4a55eb1e"
  end

  # AOSC OS / upstream PR 15: handle glibc fgets(..., 1) correctly.
  patch do
    url "https://raw.githubusercontent.com/AOSC-Dev/aosc-os-abbs/1455c7aba657718f19fa5c3488923606b67a03ad/app-devel/unifdef/autobuild/patches/0002-GENTOO-Fix-fgets-.-size-1.patch"
    sha256 "3620bfda693d02e49a23e3208b21e8809a19088b9657cfcbb2e6e3e223716755"
  end

  def install
    system "make", "prefix=#{prefix}", "install"
  end

  test do
    pipe_output(bin/"unifdef", "echo ''")
  end
end
