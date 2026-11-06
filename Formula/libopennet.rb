class Libopennet < Formula
  desc "Provides open_net() (similar to open())"
  homepage "https://rkeene.org/oss/libopennet"
  url "https://rkeene.org/files/oss/libopennet/libopennet-0.9.9.tar.gz"
  sha256 "d1350abe17ac507ffb50d360c5bf8290e97c6843f569a1d740f9c1d369200096"
  license all_of: ["GPL-2.0-or-later", "LGPL-2.1-or-later"]

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "12b3b9fd66120ddb1837c1dee6b5dd018fb6510941edc54132bd94d43be66254"
  end

  livecheck do
    url :homepage
    regex(/href=.*?libopennet[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  on_arm do
    # Added automake as a build dependency to update config files for ARM support.
    depends_on "automake" => :build
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    if Hardware::CPU.arm?
      # Workaround for ancient config files not recognizing aarch64 macos.
      %w[config.guess config.sub].each do |fn|
        cp Formula["automake"].share/"automake-#{Formula["automake"].version.major_minor}"/fn, fn
      end
    end
    # Fix flat namespace usage.
    inreplace "configure", "-flat_namespace -undefined suppress", "-undefined dynamic_lookup"

    system "./configure", "--build=loongarch64-unknown-linux-gnu", *std_configure_args, "--mandir=#{man}"
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <opennet.h>
      #include <stdio.h>

      int main(void) {
        char buffer[32];
        NETFILE *file = fopen_net("input.txt", "r");
        if (!file || !fgets_net(buffer, sizeof(buffer), file)) return 1;
        if (fclose_net(file) != 0) return 1;
        printf("%s", buffer);
        return 0;
      }
    C
    (testpath/"input.txt").write "libopennet works\n"
    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lopennet", "-o", "test"
    assert_equal "libopennet works\n", shell_output("./test")
  end
end
