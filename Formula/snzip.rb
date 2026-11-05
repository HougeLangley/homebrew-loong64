class Snzip < Formula
  desc "Compression/decompression tool based on snappy"
  homepage "https://github.com/kubo/snzip"
  url "https://github.com/kubo/snzip/releases/download/v1.0.5/snzip-1.0.5.tar.gz"
  sha256 "fbb6b816619628f385b62f44a00a1603be157fba6ed2d30de490b0c5e645bff8"
  license "BSD-2-Clause"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "c3b309aa199def7ef3c2ce85cb20535313ded82d7836c1b68f7ff980efea26fa"
  end


  depends_on "snappy"

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.out").write "test"
    system bin/"snzip", "test.out"
    system bin/"snzip", "-d", "test.out.sz"
  end
end
