class Ascii < Formula
  desc "List ASCII idiomatic names and octal/decimal code-point forms"
  homepage "http://www.catb.org/~esr/ascii/"
  url "https://gitlab.com/esr/ascii/-/archive/3.33/ascii-3.33.tar.bz2"
  sha256 "db92154ed708d88feef02440debe3a2011a2e7e77507f5698092722b15170a60"
  license "BSD-2-Clause"
  head "https://gitlab.com/esr/ascii.git", branch: "master"

  # The homepage links to the `stable` tarball but it can take longer than the
  # ten second livecheck timeout, so we check the Git tags as a workaround.
  livecheck do
    url :head
    regex(/^v?(\d+(?:[.-]\d+)+)$/i)
    strategy :git do |tags, regex|
      tags.filter_map { |tag| tag[regex, 1]&.tr("-", ".") }
    end
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "79e6dccb4a72dc16c6d40db865c3981585122af0420b9e17752b7b08b32819d4"
  end

  depends_on "asciidoctor" => :build

  def install
    bin.mkpath
    man1.mkpath
    system "make"
    system "make", "PREFIX=#{prefix}", "install"
  end

  test do
    assert_match "Official name: Line Feed", shell_output("#{bin}/ascii 0x0a")
  end
end
