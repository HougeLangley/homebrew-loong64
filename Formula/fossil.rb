class Fossil < Formula
  desc "Distributed software configuration management"
  homepage "https://www.fossil-scm.org/home/"
  url "https://fossil-scm.org/home/tarball/version-2.28/fossil-src-2.28.tar.gz"
  sha256 "84c18824ca227e7602d2408b663c3747f754ad306ed5c73ddab959d6589538a6"
  license "BSD-2-Clause"
  revision 1
  head "https://www.fossil-scm.org/", using: :fossil

  livecheck do
    url "https://www.fossil-scm.org/home/uv/download.js"
    regex(/"title":\s*?"Version (\d+(?:\.\d+)+)\s*?\(/i)
  end


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "33ad5a2b0e24e66ace473aea87e2e0c423d586b0fe5253fe480c93a33621e296"
  end

  depends_on "openssl@4"

  on_linux do
    depends_on "zlib-ng-compat"
  end

  def install
    args = [
      # fix a build issue, recommended by upstream on the mailing-list:
      # https://permalink.gmane.org/gmane.comp.version-control.fossil-scm.user/22444
      "--with-tcl-private-stubs=1",
      "--json",
      "--disable-fusefs",
    ]

    args << if OS.mac? && (sdk_path = MacOS.sdk_path)
      "--with-tcl=#{sdk_path}/System/Library/Frameworks/Tcl.framework"
    else
      "--with-tcl-stubs"
    end

    system "./configure", *args
    system "make"
    bin.install "fossil"
    bash_completion.install "tools/fossil-autocomplete.bash" => "fossil"
    zsh_completion.install "tools/fossil-autocomplete.zsh" => "_fossil"
  end

  test do
    system bin/"fossil", "init", "test"
  end
end
