class Argus < Formula
  desc "Audit Record Generation and Utilization System server"
  homepage "https://openargus.org"
  url "https://github.com/openargus/argus/archive/refs/tags/v5.0.4.tar.gz"
  sha256 "9c3863fd44fd2912dd763002fbe733259564b00b9b7c66b2e9b970bf2a41232d"
  license "GPL-3.0-or-later"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "b69c4d63ed6efd3a98c5925a567fae76f95484c7c395cdace6e4a493d1d27fb3"
  end

  uses_from_macos "bison" => :build
  uses_from_macos "flex" => :build
  uses_from_macos "cyrus-sasl"
  uses_from_macos "libpcap"

  on_linux do
    depends_on "libtirpc"
    depends_on "zlib-ng-compat"
  end

  deny_network_access!

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}", "dist/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    if OS.linux?
      ENV.append_to_cflags "-I#{formula_opt_include("libtirpc")}/tirpc"
      ENV.append "LIBS", "-ltirpc"
    end
    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--with-sasl", *std_configure_args
    system "make"
    system "make", "install"
  end

  test do
    assert_match "Pages", shell_output(bin/"argus-vmstat") if OS.mac?
    assert_match "Argus Version #{version}", shell_output("#{sbin}/argus -h", 255)
    system sbin/"argus", "-r", test_fixtures("test.pcap"), "-w", testpath/"test.argus"
    assert_path_exists testpath/"test.argus"
  end
end
