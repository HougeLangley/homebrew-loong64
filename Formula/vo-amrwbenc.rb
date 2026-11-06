class VoAmrwbenc < Formula
  desc "Library for the VisualOn Adaptive Multi Rate Wideband (AMR-WB) audio encoder"
  homepage "https://sourceforge.net/projects/opencore-amr/"
  url "https://downloads.sourceforge.net/project/opencore-amr/vo-amrwbenc/vo-amrwbenc-0.1.3.tar.gz"
  sha256 "5652b391e0f0e296417b841b02987d3fd33e6c0af342c69542cbb016a71d9d4e"
  license "Apache-2.0"

  livecheck do
    url "https://sourceforge.net/projects/opencore-amr/rss?path=/vo-amrwbenc"
    regex(%r{url=.*?/vo-amrwbenc[._-]v?(\d+(?:\.\d+)+)\.t}i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "7423bb70762d7286d722e5dc714109598eefb72dd8467ff5c9d798997134622a"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-silent-rules", *std_configure_args
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~CPP
      #include <vo-amrwbenc/enc_if.h>
      int main() {
        void *handle;
        handle = E_IF_init();
        E_IF_exit(handle);
        return 0;
      }
    CPP
    system ENV.cc, "test.cpp", "-L#{lib}", "-lvo-amrwbenc", "-o", "test"
    system "./test"
  end
end
