class Ccrypt < Formula
  desc "Encrypt and decrypt files and streams"
  homepage "https://ccrypt.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/ccrypt/1.11/ccrypt-1.11.tar.gz"
  sha256 "b19c47500a96ee5fbd820f704c912f6efcc42b638c0a6aa7a4e3dc0a6b51a44f"
  license "GPL-2.0-or-later"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "a278948ee7b114c10ce28b1fda317c678f9f41ad2754a7eb965927eec490869c"
  end


  conflicts_with "ccat", because: "both install `ccat` binaries"

  deny_network_access!

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    args = ["--mandir=#{man}", "--with-lispdir=#{elisp}"]
    args << "--disable-libcrypt" if OS.linux? # https://sourceforge.net/p/ccrypt/bugs/28/#22b5

    system "./configure", "--build=loongarch64-unknown-linux-gnu", *args, *std_configure_args
    system "make", "install"
    system "make", "check"
  end

  test do
    touch "homebrew.txt"
    system bin/"ccrypt", "-e", testpath/"homebrew.txt", "-K", "secret"
    assert_path_exists testpath/"homebrew.txt.cpt"
    refute_path_exists testpath/"homebrew.txt"

    system bin/"ccrypt", "-d", testpath/"homebrew.txt.cpt", "-K", "secret"
    assert_path_exists testpath/"homebrew.txt"
    refute_path_exists testpath/"homebrew.txt.cpt"
  end
end
