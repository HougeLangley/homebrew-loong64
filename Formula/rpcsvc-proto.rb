class RpcsvcProto < Formula
  desc "Rpcsvc protocol definitions from glibc"
  homepage "https://github.com/thkukuk/rpcsvc-proto"
  url "https://github.com/thkukuk/rpcsvc-proto/releases/download/v1.4.4/rpcsvc-proto-1.4.4.tar.xz"
  sha256 "81c3aa27edb5d8a18ef027081ebb984234d5b5860c65bd99d4ac8f03145a558b"
  license "BSD-3-Clause"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "dc97e2566f7c2e79bf7c17d142406ed9c6f3e77dac97a2be81b4c1fbf218cc95"
  end


  keg_only :shadowed_by_macos

  on_macos do
    depends_on "gettext"
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-silent-rules", *std_configure_args
    system "make", "install"
  end

  test do
    assert_match "nettype", shell_output("#{bin}/rpcgen 2>&1", 1)

    (testpath/"msg.x").write <<~EOS
      program MESSAGEPROG {
        version PRINTMESSAGEVERS {
          int PRINTMESSAGE(string) = 1;
        } = 1;
      } = 0x20000001;
    EOS
    system bin/"rpcgen", "msg.x"
    assert_path_exists "msg_svc.c"
  end
end
