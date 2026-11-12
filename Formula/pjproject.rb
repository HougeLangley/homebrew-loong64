class Pjproject < Formula
  desc "C library for multimedia protocols such as SIP, SDP, RTP and more"
  homepage "https://www.pjsip.org/"
  license "GPL-2.0-or-later"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "be66cc9f84cd3e9fcd15936733d77a01634b5ea81d4cb071ae65db2b634fb5fa"
  end

  head "https://github.com/pjsip/pjproject.git", branch: "master"

  stable do
    url "https://github.com/pjsip/pjproject/archive/refs/tags/2.17.tar.gz"
    sha256 "065fe06c06788d97c35f563796d59f00ce52fe9558a52d7b490a042a966facce"

    # Backport support for OpenSSL 4.0
    patch do
      url "https://github.com/pjsip/pjproject/commit/3923fad2e4f6f3403c3d6f1176b113c1c1b91066.patch?full_index=1"
      sha256 "6958040fc0b0502381aa1514cacf1d947ea1a6104b2da388e1c99870f67bc998"
      type :backport
      resolves "https://github.com/pjsip/pjproject/pull/5036"
    end
  end

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end


  depends_on "openssl@4"

  def install
    system "./configure", *std_configure_args
    ENV.deparallelize
    system "make", "dep"
    system "make"
    system "make", "install"

    arch = Hardware::CPU.arm? ? "aarch64" : Hardware::CPU.arch.to_s
    target = if OS.mac?
      "apple-darwin#{OS.kernel_version}"
    elsif Hardware::CPU.arm? || arch == "loongarch64"
      "unknown-linux-gnu"
    else
      "pc-linux-gnu"
    end

    bin.install "pjsip-apps/bin/pjsua-#{arch}-#{target}" => "pjsua"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/pjsua --version 2>&1")
  end
end
