class Node < Formula
  desc "Platform built on V8 to build network applications"
  homepage "https://nodejs.org/"
  url "https://nodejs.org/dist/v22.14.0/node-v22.14.0.tar.xz"
  sha256 "c609946bf793b55b0e52722b0c26a2c0b1f7ed4c6f5c7c0d6b5b3f5d8d9c0a1b"
  license "MIT"

  depends_on "pkgconf" => :build
  depends_on "python@3.14" => :build
  depends_on "brotli"
  depends_on "c-ares"
  depends_on "icu4c"
  depends_on "libnghttp2"
  depends_on "libuv"
  depends_on "openssl@3"
  depends_on "zlib-ng-compat"

  def install
    ENV["PYTHON"] = which("python3.14")
    
    args = %W[
      --prefix=#{prefix}
      --without-corepack
      --shared-brotli
      --shared-libuv
      --shared-nghttp2
      --shared-openssl
      --shared-zlib
      --shared-cares
      --with-intl=system-icu
    ]

    system "./configure", *args
    system "make", "install"
  end

  test do
    system bin/"node", "-e", "console.log('Hello World')"
  end
end
