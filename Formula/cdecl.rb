class Cdecl < Formula
  desc "Turn English phrases to C or C++ declarations"
  homepage "https://github.com/paul-j-lucas/cdecl"
  url "https://github.com/paul-j-lucas/cdecl/releases/download/cdecl-18.7.2/cdecl-18.7.2.tar.gz"
  sha256 "e91cc201c79456b923b45cfa779da62f5ca91824d11c545167ee7bb33a9fb810"
  license all_of: [
    "GPL-3.0-or-later",
    "LGPL-2.1-or-later", # gnulib
    :public_domain, # original cdecl
  ]


  uses_from_macos "bison" => :build
  uses_from_macos "flex" => :build
  uses_from_macos "ncurses"

  on_linux do
    depends_on "readline"
  end

  deny_network_access!

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "5117501f3e451660a95d19ca70769d7fb7f9d2564cf2383a5d5b7584de9f8c4e"
  end

  def install
    system "./configure", "--disable-silent-rules", *std_configure_args
    system "make", "install"
  end

  test do
    assert_equal "declare a as pointer to integer",
                 shell_output("#{bin}/cdecl explain int *a").strip
  end
end
