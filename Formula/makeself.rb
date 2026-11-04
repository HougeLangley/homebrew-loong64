class Makeself < Formula
  desc "Generates a self-extracting compressed tar archive"
  homepage "https://makeself.io/"
  url "https://github.com/megastep/makeself/archive/refs/tags/release-2.7.1.tar.gz"
  sha256 "96843e5db70da71dcb3cb594a6899886043f115e9205c6b5ca2f26000389514e"
  license "GPL-2.0-or-later"
  head "https://github.com/megastep/makeself.git", branch: "master"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "9c31e2aee59c0cd2f0650302f932e443a462d40a7afe75af74179272d7d53d43"
  end

  def install
    libexec.install "makeself-header.sh"
    # install makeself-header.sh to libexec so change its location in makeself.sh
    inreplace "makeself.sh", '`dirname "$0"`', libexec
    bin.install "makeself.sh" => "makeself"
    man1.install "makeself.1"
  end

  test do
    source = testpath/"source"
    source.mkdir
    (source/"foo").write "bar"
    (source/"script.sh").write <<~SH
      #!/bin/sh
      echo 'Hello Homebrew!'
    SH
    chmod 0755, source/"script.sh"
    system bin/"makeself", source, "testfile.run", "'A test file'", "./script.sh"
    assert_match "Hello Homebrew!", shell_output("./testfile.run --target output")
    assert_equal (source/"foo").read, (testpath/"output/foo").read
  end
end
