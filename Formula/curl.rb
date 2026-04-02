class Curl < Formula
  desc "Get a file from an HTTP, HTTPS or FTP server"
  homepage "https://curl.se"
  url "https://curl.se/download/curl-8.19.0.tar.bz2"
  sha256 "eba3230c1b659211a7afa0fbf475978cbf99c412e4d72d9aa92d020c460742d4"
  license "curl"

  bottle do
    root_url "https://homebrewloongarch64.site/bottles/loong64"
    rebuild 1
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "9a20433dcc01efa8ecb539d571599164458e786e0be4b4f24088c28d55c1a471"
  end

  depends_on "ca-certificates"
  depends_on "libnghttp2"
  depends_on "libssh2"
  depends_on "openssl@3"
  depends_on "zstd"
  depends_on "zlib-ng-compat"

  def install
    cpu = Hardware::CPU.loongarch? ? "loongarch64" : Hardware.oldest_cpu
    ENV["CFLAGS"] = "-Wno-error"
    
    args = [
      "--disable-silent-rules",
      "--prefix=#{prefix}",
      "--with-ssl=#{Formula["openssl@3"].opt_prefix}",
      "--without-ca-bundle",
      "--without-ca-path",
      "--with-ca-fallback",
      "--without-librtmp",
      "--with-libssh2",
      "--without-libpsl",
      "--with-zlib=#{Formula["zlib-ng-compat"].opt_prefix}",
      "--with-zstd",
      "--with-libnghttp2",
      "--build=#{cpu}-unknown-linux-gnu",
      "--disable-dependency-tracking"
    ]

    system "./configure", *args
    system "make", "install"
  end

  test do
    system "#{bin}/curl", "-V"
  end
end
