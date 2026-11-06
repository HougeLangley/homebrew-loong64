class Doh < Formula
  desc "Stand-alone DNS-over-HTTPS resolver using libcurl"
  homepage "https://github.com/curl/doh"
  url "https://github.com/curl/doh/archive/refs/tags/doh-0.1.tar.gz"
  sha256 "b36c4b4a27fabb508d5d3bb0fb58bd9cfadcef30d22e552bbe5c4442ae81e742"
  license "MIT"
  head "https://github.com/curl/doh.git", branch: "master"


  uses_from_macos "curl"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "579e93306e548fe2755211596bb119252e932b5c92b9757a95d7c2caa248958b"
  end

  def install
    system "make"
    bin.install "doh"
    man1.install "doh.1"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/doh -V")

    output = shell_output("#{bin}/doh google.com https://dns.google/dns-query")
    assert_match "google.com", output
  end
end
