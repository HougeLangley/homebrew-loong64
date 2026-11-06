class WithReadline < Formula
  desc "Allow GNU Readline to be used with arbitrary programs"
  homepage "https://www.greenend.org.uk/rjk/sw/withreadline.html"
  url "https://www.greenend.org.uk/rjk/sw/with-readline-0.1.1.tar.gz"
  sha256 "d12c71eb57ef1dbe35e7bd7a1cc470a4cb309c63644116dbd9c88762eb31b55d"
  license "GPL-2.0-or-later"
  revision 2

  livecheck do
    url :homepage
    regex(/href=.*?with-readline[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end



  depends_on "readline"

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", *std_configure_args
    system "make", "install"
  end

  test do
    pipe_output("#{bin}/with-readline dash", "exit", 0)
  end
end
