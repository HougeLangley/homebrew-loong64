class Saldl < Formula
  desc "CLI downloader optimized for speed and early preview"
  homepage "https://saldl.github.io/"
  url "https://github.com/saldl/saldl/archive/refs/tags/v41.tar.gz"
  sha256 "fc9980922f1556fd54a8c04fd671933fdc5b1e6847c1493a5fec89e164722d8e"
  license "AGPL-3.0-or-later"
  bottle do
    rebuild 3
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "46270a585a247e1949507de1188c44a731ed45a1527984859a02b7d87cec3c60"
  end

  head "https://github.com/saldl/saldl.git", branch: "master"



  depends_on "asciidoc" => :build
  depends_on "docbook-xsl" => :build
  depends_on "pkgconf" => :build
  depends_on "libevent"

  uses_from_macos "libxml2" => :build
  uses_from_macos "libxslt" => :build
  uses_from_macos "python" => :build
  uses_from_macos "curl"

  # Update waf for python 3.11
  # Use resource instead of patch since applying corrupts waf
  # https://github.com/saldl/saldl/pull/15
  resource "waf" do
    url "https://raw.githubusercontent.com/saldl/saldl/360c29d6c8cee5f7e608af42237928be429c3407/waf"
    sha256 "93909bca823a675f9f40af7c65b24887c3a3c0efdf411ff1978ba827194bdeb0"
  end

  allow_network_access! :test

  def install
    ENV.refurbish_args

    # a2x/asciidoc needs this to build the man page successfully
    ENV["XML_CATALOG_FILES"] = etc/"xml/catalog"

    args = ["--prefix=#{prefix}"]

    # head uses git describe to acquire a version
    args << "--saldl-version=v#{version}" if build.stable?

    buildpath.install resource("waf")
    system "python3", "./waf", "configure", *args
    system "python3", "./waf", "build"
    system "python3", "./waf", "install"
  end

  test do
    system bin/"saldl", "https://brew.sh/index.html"
    assert_path_exists testpath/"index.html"
  end
end
