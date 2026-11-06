class BaculaFd < Formula
  desc "Network backup solution"
  homepage "https://www.bacula.org/"
  url "https://downloads.sourceforge.net/project/bacula/bacula/15.0.3/bacula-15.0.3.tar.gz"
  sha256 "294afd3d2eb9d5b71c3d0e88fdf19eb513bfdb843b28d35c0552e4ae062827a1"
  license "AGPL-3.0-only" => { with: "openvpn-openssl-exception" }

  livecheck do
    url "https://sourceforge.net/projects/bacula/rss?path=/bacula"
    regex(%r{url=.*?/bacula(?:(?!/[^/]*beta[^/]*)/[^/]+)*/bacula[._-]v?(\d+(?:\.\d+)+)\.t}i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "c54391abfbcee87f54c1f76340861846e60b04689d1a95eda49287c70ec02933"
  end

  depends_on "openssl@4"
  depends_on "readline"

  on_linux do
    depends_on "zlib-ng-compat"
  end

  conflicts_with "bareos-client", because: "both install a `bconsole` executable"

  # Fix -flat_namespace being used on Big Sur and later.
  patch do
    file "Patches/libtool/configure-pre-0.4.2.418-big_sur.diff"
    type :unofficial
  end

  # Apply Ubuntu patch to support OpenSSL 4. Used by Fedora too.
  patch do
    url "https://git.launchpad.net/ubuntu/+source/bacula/plain/debian/patches/ubuntu/openssl-4-ftbfs.patch?id=0ff2f2f11dee0bbdfb5059d35379088fbe7ae5ab"
    sha256 "841443a121aa2d61c8156a7e9029113ea659cc24d2d610c2d93a498655272ab8"
    type :unofficial
    resolves "https://gitlab.bacula.org/bacula-community-edition/bacula-community/-/work_items/2771"
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

    # CoreFoundation is also used alongside IOKit
    inreplace "configure", '"-framework IOKit"',
                           '"-framework IOKit -framework CoreFoundation"'

    # * sets --disable-conio in order to force the use of readline
    #   (conio support not tested)
    # * working directory in /var/lib/bacula, reasonable place that
    #   matches Debian's location.
    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--prefix=#{prefix}",
                          "--sbindir=#{bin}",
                          "--with-working-dir=#{var}/lib/bacula",
                          "--with-pid-dir=#{var}/run",
                          "--with-logdir=#{var}/log/bacula",
                          "--enable-client-only",
                          "--disable-conio",
                          "--with-readline=#{formula_opt_prefix("readline")}"

    system "make"
    system "make", "install"

    # Avoid references to the Homebrew shims directory
    inreplace prefix/"etc/bacula_config", "#{Superenv.shims_path}/", ""

    (var/"lib/bacula").mkpath
    (var/"run").mkpath
  end

  service do
    run [opt_bin/"bacula-fd", "-f"]
    require_root true
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bacula-fd -? 2>&1", 1)
  end
end
