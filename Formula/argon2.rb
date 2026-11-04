class Argon2 < Formula
  desc "Password hashing library and CLI utility"
  homepage "https://github.com/P-H-C/phc-winner-argon2"
  url "https://github.com/P-H-C/phc-winner-argon2/archive/refs/tags/20190702.tar.gz"
  sha256 "daf972a89577f8772602bf2eb38b6a3dd3d922bf5724d45e7f9589b5e830442c"
  license any_of: ["CC0-1.0", "Apache-2.0"]
  revision 1
  head "https://github.com/P-H-C/phc-winner-argon2.git", branch: "master"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "ef9ed6ea4037683a10a3f90dc4d84e2276e2ad3295076e6a140bfcd780ac9250"
  end

  def install
    system "make", "PREFIX=#{prefix}", "ARGON2_VERSION=#{version}", "LIBRARY_REL=lib"
    system "make", "test"
    system "make", "install", "PREFIX=#{prefix}", "ARGON2_VERSION=#{version}", "LIBRARY_REL=lib"
    doc.install "argon2-specs.pdf"
  end

  test do
    output = pipe_output("#{bin}/argon2 somesalt -t 2 -m 16 -p 4", "password", 0)
    assert_match "c29tZXNhbHQ$IMit9qkFULCMA/ViizL57cnTLOa5DiVM9eMwpAvPw", output
  end
end
