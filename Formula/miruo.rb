class Miruo < Formula
  desc "Pretty-print TCP session monitor/analyzer"
  homepage "https://github.com/KLab/miruo/"
  url "https://github.com/KLab/miruo/archive/refs/tags/0.9.6b.tar.gz"
  version "0.9.6b"
  sha256 "0b31a5bde5b0e92a245611a8e671cec3d330686316691daeb1de76360d2fa5f1"
  license "GPL-3.0-only"


  uses_from_macos "libpcap"

  patch do
    url "https://github.com/KLab/miruo/commit/6f0dde8b60d0a1981620539506be3d9b600aac18.patch?full_index=1"
    sha256 "14498789cfbf3d755deeade28906cda4684a14ac7bfc4f0a80ff990d5e5304f3"
    type :backport
    resolves "https://github.com/KLab/miruo/pull/19"
  end

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "c68ab5ff9fe86a92150096e26cb7cafeb1ac10fadf62d18a42c814380d403521"
  end

  def install
    args = %W[
      --prefix=#{prefix}
      --disable-dependency-tracking
    ]
    args << "--with-libpcap=#{MacOS.sdk_path}/usr" if OS.mac?
    system "./configure", *args
    system "make", "install"
  end

  test do
    (testpath/"dummy.pcap").write "\xd4\xc3\xb2\xa1\x02\x00\x04\x00\x00\x00\x00\x00" \
                                  "\x00\x00\x00\x00\xff\xff\x00\x00\x01\x00\x00\x00"
    system sbin/"miruo", "--file=dummy.pcap"
  end
end
