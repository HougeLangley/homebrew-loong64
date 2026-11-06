class AlsaLib < Formula
  desc "Provides audio and MIDI functionality to the Linux operating system"
  homepage "https://www.alsa-project.org/"
  url "https://www.alsa-project.org/files/pub/lib/alsa-lib-1.2.16.1.tar.bz2"
  sha256 "f740db7f488255944ffd4428416ee3390a96742856916433df468c281436480e"
  license all_of: ["LGPL-2.1-or-later", "GPL-2.0-or-later"]
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "b7fe8d46cb6eafeb5efdda4b75b287603758e765ab7c9bb4e0dcdfedb058f327"
  end

  revision 1
  compatibility_version 1

  livecheck do
    url "https://www.alsa-project.org/files/pub/lib/"
    regex(/href=.*?alsa-lib[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  depends_on :linux

  deny_network_access!

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    args = %W[
      --disable-silent-rules
      --with-plugindir=#{HOMEBREW_PREFIX}/lib/alsa-lib
    ]
    system "./configure", "--build=loongarch64-unknown-linux-gnu", *args, *std_configure_args
    system "make", "install"
    prefix.install "aserver/COPYING" => "COPYING-aserver"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <alsa/asoundlib.h>
      int main(void)
      {
          snd_ctl_card_info_t *info;
          snd_ctl_card_info_alloca(&info);
          return 0;
      }
    C
    system ENV.cc, "test.c", "-L#{lib}", "-lasound", "-o", "test"
    system "./test"
  end
end
