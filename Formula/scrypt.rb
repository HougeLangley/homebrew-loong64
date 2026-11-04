class Scrypt < Formula
  desc "Encrypt and decrypt files using memory-hard password function"
  homepage "https://www.tarsnap.com/scrypt.html"
  url "https://www.tarsnap.com/scrypt/scrypt-1.3.3.tgz"
  sha256 "1c2710517e998eaac2e97db11f092e37139e69886b21a1b2661f64e130215ae9"
  license "BSD-2-Clause"


  head do
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "e61f096fc6928e62cabfa457fc5f3db4561e536f42d2000eac7cd70ff00f3789"
  end

    url "https://github.com/Tarsnap/scrypt.git", branch: "master"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
  end

  depends_on "openssl@4"

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "autoreconf", "--force", "--install", "--verbose" if build.head?
    system "./configure", "--build=loongarch64-unknown-linux-gnu", *std_configure_args
    system "make", "install"
  end

  test do
    require "expect"
    require "pty"

    touch "homebrew.txt"
    PTY.spawn(bin/"scrypt", "enc", "homebrew.txt", "homebrew.txt.enc") do |r, w, _pid|
      r.expect "Please enter passphrase: "
      w.write "Testing\n"
      r.expect "Please confirm passphrase: "
      w.write "Testing\n"
      r.read
    rescue Errno::EIO
      # GNU/Linux raises EIO when read is done on closed pty
    end

    assert_path_exists testpath/"homebrew.txt.enc"
  end
end
