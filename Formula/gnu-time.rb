class GnuTime < Formula
  desc "GNU implementation of time utility"
  homepage "https://www.gnu.org/software/time/"
  url "https://ftpmirror.gnu.org/time/time-1.10.tar.gz"
  mirror "https://ftp.gnu.org/gnu/time/time-1.10.tar.gz"
  sha256 "e8c29fb4ab599d8478e41e8618f50db8aede9c90af27d0d2ef28ae50d5de09c3"
  license "GPL-3.0-or-later"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "3ae1316e0e2196028b874c885c07d7c88a04b74c46dcc9aeb2864ffaa77cda2d"
  end


  uses_from_macos "ruby" => :test

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    args = %W[
      --prefix=#{prefix}
      --info=#{info}
    ]

    args << "--program-prefix=g" if OS.mac?
    system "./configure", "--build=loongarch64-unknown-linux-gnu", *args
    system "make", "install"

    (libexec/"gnubin").install_symlink bin/"gtime" => "time" if OS.mac?
  end

  def caveats
    on_macos do
      <<~EOS
        GNU "time" has been installed as "gtime".
        If you need to use it as "time", you can add a "gnubin" directory
        to your PATH from your bashrc like:

            PATH="#{opt_libexec}/gnubin:$PATH"
      EOS
    end
  end

  test do
    if OS.mac?
      system bin/"gtime", "ruby", "--version"
      system opt_libexec/"gnubin/time", "ruby", "--version"
    else
      system bin/"time", "ruby", "--version"
    end
  end
end
