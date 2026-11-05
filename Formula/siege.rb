class Siege < Formula
  desc "HTTP regression testing and benchmarking utility"
  homepage "https://www.joedog.org/siege"
  url "https://download.joedog.org/siege/siege-4.2.0.tar.gz"
  sha256 "78af482fc655f1cf7270fdbc3171581ed4cb3163009f7f4f056fc2b7e2d24453"
  license "GPL-3.0-or-later"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "d52fa915c875687c01aa0e8d8d739892154b104a6ad554568cb17ddda21ec783"
  end

  livecheck do
    url "https://download.joedog.org/siege/?C=M&O=D"
    regex(/href=.*?siege[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  depends_on "openssl@4"

  on_linux do
    depends_on "zlib-ng-compat"
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    # workaround for newer clang
    # notified upstream on the site on 2024-09-10
    ENV.append_to_cflags "-Wno-int-conversion" if DevelopmentTools.clang_build_version >= 1403

    # To avoid unnecessary warning due to hardcoded path, create the folder first
    (prefix/"etc").mkdir

    zlib = OS.mac? ? "#{MacOS.sdk_path}/usr" : formula_opt_prefix("zlib-ng-compat")
    args = %W[
      --localstatedir=#{var}
      --with-ssl=#{formula_opt_prefix("openssl@4")}
      --with-zlib=#{zlib}
    ]

    system "./configure", "--build=loongarch64-unknown-linux-gnu", *args, *std_configure_args
    system "make", "install"
  end

  def caveats
    <<~EOS
      macOS has only 16K ports available that won't be released until socket
      TIME_WAIT is passed. The default timeout for TIME_WAIT is 15 seconds.
      Consider reducing in case of available port bottleneck.

      You can check whether this is a problem with netstat:

          # sysctl net.inet.tcp.msl
          net.inet.tcp.msl: 15000

          # sudo sysctl -w net.inet.tcp.msl=1000
          net.inet.tcp.msl: 15000 -> 1000

      Run siege.config to create the ~/.siegerc config file.
    EOS
  end

  test do
    system bin/"siege", "--concurrent=1", "--reps=1", "https://www.google.com/"
  end
end
