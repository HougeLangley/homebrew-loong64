class Texinfo < Formula
  desc "Official documentation format of the GNU project"
  homepage "https://www.gnu.org/software/texinfo/"
  url "https://ftpmirror.gnu.org/texinfo/texinfo-7.3.tar.xz"
  mirror "https://ftp.gnu.org/gnu/texinfo/texinfo-7.3.tar.xz"
  sha256 "51f74eb0f51cfa9873b85264dfdd5d46e8957ec95b88f0fb762f63d9e164c72e"
  license "GPL-3.0-or-later"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "69d16677887c324036df12eba829d8fed5da0d8aabf7f6e85ac93c02f390724b"
  end

  revision 1
  compatibility_version 1


  uses_from_macos "ncurses"
  uses_from_macos "perl"

  on_linux do
    depends_on "libunistring"
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-install-warnings", *std_configure_args
    system "make", "install"
    doc.install Dir["doc/refcard/txirefcard*"]

    (libexec/"post-install").write <<~SH
      #!/bin/sh
      info_dir="#{HOMEBREW_PREFIX}/share/info/dir"
      rm -f "$info_dir"
      for file in "#{HOMEBREW_PREFIX}/share/info/"*.info "#{HOMEBREW_PREFIX}/share/info/"*.info.gz; do
        [ -e "$file" ] || continue
        "#{opt_bin}/install-info" --quiet "$file" "$info_dir" || true
      done
    SH
    chmod 0755, libexec/"post-install"
  end

  post_install_steps do
    run "post-install", base: :libexec
  end

  test do
    (testpath/"test.texinfo").write <<~EOS
      @ifnottex
      @node Top
      @top Hello World!
      @end ifnottex
      @bye
    EOS

    system bin/"makeinfo", "test.texinfo"
    assert_match "Hello World!", (testpath/"test.info").read
  end
end
