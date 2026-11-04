class Mktorrent < Formula
  desc "Create BitTorrent metainfo files"
  homepage "https://github.com/pobrn/mktorrent/wiki"
  url "https://github.com/pobrn/mktorrent/archive/refs/tags/v1.1.tar.gz"
  sha256 "d0f47500192605d01b5a2569c605e51ed319f557d24cfcbcb23a26d51d6138c9"
  license "GPL-2.0-or-later"
  revision 3


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "d6e21abc401ea60636b1841f018438ef253bda5509f761e0bc3f2c1ad50e87fd"
  end

  depends_on "openssl@4"

  def install
    system "make", "USE_PTHREADS=1", "USE_OPENSSL=1", "USE_LONG_OPTIONS=1"
    bin.install "mktorrent"
  end

  test do
    (testpath/"test.txt").write <<~EOS
      Injustice anywhere is a threat to justice everywhere.
    EOS

    system bin/"mktorrent", "-d", "-c", "Martin Luther King Jr", "test.txt"
    assert_path_exists testpath/"test.txt.torrent", "Torrent was not created"

    file = File.read(testpath/"test.txt.torrent")
    output = file.force_encoding("ASCII-8BIT") if file.respond_to?(:force_encoding)
    assert_match "Martin Luther King Jr", output
  end
end
