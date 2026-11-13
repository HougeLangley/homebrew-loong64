class Chrpath < Formula
  desc "Tool to edit the rpath in ELF binaries"
  homepage "https://tracker.debian.org/pkg/chrpath"
  url "https://deb.debian.org/debian/pool/main/c/chrpath/chrpath_0.18.orig.tar.gz"
  sha256 "f09c49f0618660ca11fc6d9580ddde904c7224d4c6d0f6f2d1f9bcdc9102c9aa"
  license "GPL-2.0-or-later"

  livecheck do
    skip "Not actively developed or maintained"
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "5983a80601eb5fd45d5f0c11093ccfc9dad54f6f796eb779ac4a1fdab06c26c1"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on :linux

  deny_network_access!

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}", "dist/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "autoreconf", "--force", "--install", "--verbose"
    system "./configure", "--build=loongarch64-unknown-linux-gnu", *std_configure_args, "--disable-silent-rules"
    system "make", "install"
  end

  test do
    assert_match "chrpath version #{version}", shell_output("#{bin}/chrpath -v")
    (testpath/"test.c").write "int main(){return 0;}"
    system ENV.cc, "test.c", "-Wl,-rpath,/usr/local/lib"
    # GNU ld on LoongArch emits DT_RPATH here, not DT_RUNPATH.
    assert_match(%r{a\.out: R(?:UN)?PATH=/usr/local/lib}, shell_output("#{bin}/chrpath a.out"))
    assert_match(%r{a\.out: new R(?:UN)?PATH: /usr/lib/}, shell_output("#{bin}/chrpath -r /usr/lib/ a.out"))
    assert_match(%r{a\.out: R(?:UN)?PATH=/usr/lib/},      shell_output("#{bin}/chrpath a.out"))
    system bin/"chrpath", "-d", "a.out"
    assert_match "a.out: no rpath or runpath tag found.", shell_output("#{bin}/chrpath a.out", 2)
  end
end
