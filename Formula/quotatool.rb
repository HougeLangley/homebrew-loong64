class Quotatool < Formula
  desc "Edit disk quotas from the command-line"
  homepage "https://quotatool.ekenberg.se/"
  url "https://github.com/ekenberg/quotatool.git",
      tag:      "v1.8.0",
      revision: "cae3d2d9407f2115a96b227542930a5a7ec52ace"
  license "GPL-2.0-or-later"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_linux:  "badbc7789884179f26f459091309b7684966888dbab9ae535a432c56379aebf4"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d9915dfded9da0855dba04c841dc3c7c1ac33b94dfb68ce10dbcd18552f313b0"
  end

  depends_on :linux

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--prefix=#{prefix}"
    sbin.mkpath
    man8.mkpath
    system "make", "install"
  end

  test do
    system sbin/"quotatool", "-V"
  end
end
