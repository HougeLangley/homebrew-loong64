class Libxshmfence < Formula
  desc "X.Org: Shared memory 'SyncFence' synchronization primitive"
  homepage "https://www.x.org/"
  url "https://xorg.freedesktop.org/archive/individual/lib/libxshmfence-1.3.3.tar.xz"
  sha256 "d4a4df096aba96fea02c029ee3a44e11a47eb7f7213c1a729be83e85ec3fde10"
  license "MIT"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "9586e65f2b0d849d047cd2e69c0c97d2dd6844455452cd7f1b1b29d63596407b"
  end


  depends_on "pkgconf" => :build
  depends_on "xorgproto" => [:build, :test]

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    args = %W[
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-silent-rules
    ]

    system "./configure", "--build=loongarch64-unknown-linux-gnu", *args, *std_configure_args
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include "X11/xshmfence.h"

      int main(int argc, char* argv[]) {
        struct xshmfence *fence;
        return 0;
      }
    C
    system ENV.cc, "test.c"
    assert_equal 0, $CHILD_STATUS.exitstatus
  end
end
