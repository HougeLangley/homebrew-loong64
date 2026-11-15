class Mp3fs < Formula
  desc "Read-only FUSE file system: transcodes audio formats to MP3"
  homepage "https://khenriks.github.io/mp3fs/"
  url "https://github.com/khenriks/mp3fs/releases/download/v1.1.1/mp3fs-1.1.1.tar.gz"
  sha256 "942b588fb623ea58ce8cac8844e6ff2829ad4bc9b4c163bba58e3fa9ebc15608"
  license "GPL-3.0-or-later"
  revision 5


  # Last release on 2021-03-08. Needs `libfuse@2` to build.
  # Can be undeprecated if https://github.com/khenriks/mp3fs/pull/81 is merged
  deprecate! date: "2026-06-21", because: :unmaintained
  disable! date: "2027-06-21", because: :unmaintained


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "1c0ad6b1e8bc833237c0479b5bd42bd5e25e9ff18ea4a91f49bb5d50fd90ede1"
  end

  depends_on "pkgconf" => :build
  depends_on "flac"
  depends_on "lame"
  depends_on "libfuse@2"
  depends_on "libid3tag"
  depends_on "libvorbis"
  depends_on :linux # on macOS, requires closed-source macFUSE

  def install
    system "./configure", *std_configure_args
    system "make", "install"
  end

  test do
    assert_match "mp3fs version: #{version}", shell_output("#{bin}/mp3fs -V")
  end
end
