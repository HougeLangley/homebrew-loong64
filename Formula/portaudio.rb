class Portaudio < Formula
  desc "Cross-platform library for audio I/O"
  homepage "https://www.portaudio.com"
  url "https://files.portaudio.com/archives/pa_stable_v190700_20210406.tgz"
  version "19.7.0"
  sha256 "47efbf42c77c19a05d22e627d42873e991ec0c1357219c0d74ce6a2948cb2def"
  license "MIT"
  version_scheme 1
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "ac5ab7410879c13147a14700fbd6ea65a8b6cdfcfb5cfdf02df081a4e46bb938"
  end

  head "https://github.com/PortAudio/portaudio.git", branch: "master"

  livecheck do
    url "https://files.portaudio.com/download.html"
    regex(/href=.*?pa[._-]stable[._-]v?(\d+)(?:[._-]\d+)?\.t/i)
    strategy :page_match do |page, regex|
      # Modify filename version (190700) to match formula version (19.7.0)
      page.scan(regex).map { |match| match[0].scan(/\d{2}/).map(&:to_i).join(".") }
    end
  end



  depends_on "pkgconf" => :build

  on_linux do
    depends_on "alsa-lib"
    depends_on "jack"
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "buildaux/#{cf}", "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}", "dist/#{cf}"].each do |rel|
        src = "/usr/share/libtool/build-aux/#{cf}"
        dest = buildpath/rel
        if dest.exist? && File.exist?(src)
          File.chmod(0644, dest)
          cp src, dest
        end
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--enable-mac-universal=no",
                          "--enable-cxx",
                          *std_configure_args
    system "make", "install"

    # Need 'pa_mac_core.h' to compile PyAudio
    include.install "include/pa_mac_core.h" if OS.mac?
  end

  test do
    (testpath/"test.c").write <<~C
      #include <stdio.h>
      #include "portaudio.h"

      int main() {
        printf("%s",Pa_GetVersionInfo()->versionText);
      }
    C

    (testpath/"test.cpp").write <<~CPP
      #include <iostream>
      #include "portaudiocpp/System.hxx"

      int main() {
        std::cout << portaudio::System::versionText();
      }
    CPP

    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lportaudio", "-o", "test"
    system ENV.cxx, "test.cpp", "-I#{include}", "-L#{lib}", "-lportaudiocpp", "-o", "test_cpp"
    assert_match stable.version.to_s, shell_output("./test")
    assert_match stable.version.to_s, shell_output("./test_cpp")
  end
end
