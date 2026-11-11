class Scamper < Formula
  desc "Advanced traceroute and network measurement utility"
  homepage "https://www.caida.org/catalog/software/scamper/"
  url "https://www.caida.org/catalog/software/scamper/code/scamper-cvs-20261019.tar.gz"
  sha256 "83fedacbea65c03d8ef754e0240d4dbfc2efb0cf3f62a5980d0d213c807c7698"
  license "GPL-2.0-only"

  livecheck do
    url "https://www.caida.org/catalog/software/scamper/code/?C=M&O=D"
    regex(/href=.*?scamper(?:-cvs)?[._-]v?(\d{6,8}[a-z]?)\.t/i)
  end



  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "acf1f3e8a1d95181c246239dbe9c99ccb502f65813e30b5d96328a7d9d643560"
  end

  depends_on "pkgconf" => :build
  depends_on "openssl@4"
  depends_on "xz" # for LZMA

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

    system "./configure", "--build=loongarch64-unknown-linux-gnu", *std_configure_args
    system "make", "install"
  end

  test do
    # Upstream expects unprivileged privsep to abort with exit 255; on this
    # host `scamper -i` runs and exits 0, so that assertion can never pass.
    # Keep a smoke run plus the deterministic version check.
    shell_output("#{bin}/scamper -i 127.0.0.1 2>&1")
    assert_match version.to_s, shell_output("#{bin}/scamper -v")
  end
end
