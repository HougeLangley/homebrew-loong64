class Ext4fuse < Formula
  desc "Read-only implementation of ext4 for FUSE"
  homepage "https://github.com/gerard/ext4fuse"
  url "https://github.com/gerard/ext4fuse/archive/refs/tags/v0.1.3.tar.gz"
  sha256 "550f1e152c4de7d4ea517ee1c708f57bfebb0856281c508511419db45aa3ca9f"
  license "GPL-2.0-only"
  head "https://github.com/gerard/ext4fuse.git", branch: "master"


  # Last release on 2013-02-07, last activity 2020-09-29. Needs `libfuse@2` to build
  deprecate! date: "2026-06-21", because: :unmaintained
  disable! date: "2027-06-21", because: :unmaintained

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "fa1adaa4b04334d90397bdde9580c6c299fee49d4df9b2753598d2923cea665e"
  end

  depends_on "pkgconf" => :build
  depends_on "libfuse@2"
  depends_on :linux # on macOS, requires closed-source macFUSE

  deny_network_access!

  def install
    system "make"
    bin.install "ext4fuse"
  end

  test do
    # Mounting requires FUSE, so check that the superblock is read and validated before mounting
    (testpath/"test.img").write "\0" * 4096
    (testpath/"mnt").mkpath
    output = shell_output("#{bin}/ext4fuse test.img mnt 2>&1", 1)
    assert_match "Partition doesn't contain EXT4 filesystem", output
  end
end
