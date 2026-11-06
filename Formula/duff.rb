class Duff < Formula
  desc "Quickly find duplicates in a set of files from the command-line"
  homepage "https://github.com/elmindreda/duff"
  url "https://downloads.sourceforge.net/project/duff/duff/0.5.2/duff-0.5.2.tar.gz"
  sha256 "15b721f7e0ea43eba3fd6afb41dbd1be63c678952bf3d80350130a0e710c542e"
  license "Zlib"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "4fc757746c7c395f8ba39e1ef75da7e53b17c28237d4d0b7e8056f38bd3fc43b"
  end


  deny_network_access!

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    args = ["--mandir=#{man}"]
    # Help old config scripts identify arm64 linux
    args << "--build=aarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    args << "--build=loongarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arch == :loongarch64

    system "./configure", *args, *std_configure_args
    system "make", "install"
  end

  test do
    expected = <<~EOS
      2 files in cluster 1 (6 bytes, digest 8843d7f92416211de9ebb963ff4ce28125932878)
      cmp1
      cmp2
    EOS

    (testpath/"cmp1").write "foobar"
    (testpath/"cmp2").write "foobar"

    assert_equal expected, shell_output("#{bin}/duff cmp1 cmp2")
  end
end
