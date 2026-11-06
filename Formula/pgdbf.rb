class Pgdbf < Formula
  desc "Converter of XBase/FoxPro tables to PostgreSQL"
  homepage "https://github.com/kstrauser/pgdbf"
  url "https://downloads.sourceforge.net/project/pgdbf/pgdbf/0.6.2/pgdbf-0.6.2.tar.xz"
  sha256 "e46f75e9ac5f500bd12c4542b215ea09f4ebee638d41dcfd642be8e9769aa324"
  license "GPL-3.0-or-later"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "87c359deb058e54c93db9cf54544e89ef945b9ebed17805fbfb7154ae04eadba"
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

    args = []
    # Help old config scripts identify arm64 linux
    args << "--build=aarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    args << "--build=loongarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arch == :loongarch64

    system "./configure", *args, *std_configure_args
    system "make", "install"
  end

  test do
    # Build a minimal dBase III table with a character and a numeric column
    fields = [["NAME", "C", 10, 0], ["AGE", "N", 3, 0]]
    header = [0x03, 124, 1, 1, 2, 32 + (32 * fields.length) + 1, 1 + 10 + 3].pack("CCCCVvv") + ("\0" * 20)
    fields.each do |name, type, len, dec|
      header += name.ljust(11, "\0") + type + [0, len, dec].pack("VCC") + ("\0" * 14)
    end
    header += "\r"
    records = " #{"Alice".ljust(10)} 42" + " #{"Bob".ljust(10)}  7"
    (testpath/"test.dbf").binwrite header + records + "\x1A"

    output = shell_output("#{bin}/pgdbf #{testpath}/test.dbf")
    assert_match "CREATE TABLE test (name VARCHAR(10), age NUMERIC(3));", output
    assert_match "\\COPY test FROM STDIN\nAlice\t42\nBob\t7\n\\.\n", output
  end
end
