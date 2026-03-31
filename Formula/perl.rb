class Perl < Formula
  desc "Highly capable, feature-rich programming language"
  homepage "https://www.perl.org/"
  url "https://www.cpan.org/src/5.0/perl-5.42.1.tar.gz"
  sha256 "6f84e6dc8cce97181d1c6aeeb552c13775c91ded3c6c73743c9211af87b16bf8"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  depends_on "gdbm"
  depends_on "libxcrypt"

  uses_from_macos "expat"
  uses_from_macos "libxcrypt"

  def install
    args = [
      "-des",
      "-Dinstallstyle=lib/perl5",
      "-Dinstallprefix=#{prefix}",
      "-Dprefix=#{opt_prefix}",
      "-Dprivlib=#{opt_lib}/perl5/#{version.major_minor}",
      "-Dsitelib=#{opt_lib}/perl5/site_perl/#{version.major_minor}",
      "-Dotherlibdirs=#{HOMEBREW_PREFIX}/lib/perl5/site_perl/#{version.major_minor}",
      "-Dsitearch=#{opt_lib}/perl5/site_perl/#{version.major_minor}/#{Hardware::CPU.arch}-linux-thread-multi",
      "-Darchname=#{Hardware::CPU.arch}-linux-thread-multi",
      "-Dvendorprefix=#{opt_prefix}",
      "-Dvendorlib=#{opt_lib}/perl5/vendor_perl/#{version.major_minor}",
      "-Dvendorarch=#{opt_lib}/perl5/vendor_perl/#{version.major_minor}/#{Hardware::CPU.arch}-linux-thread-multi",
      "-Dman1dir=#{opt_share}/man/man1",
      "-Dman3dir=#{opt_share}/man/man3",
      "-Dhtmldir=#{opt_share}/html/perl",
      "-Duseshrplib",
      "-Duselargefiles",
      "-Dusethreads",
      "-Dnoextensions=DB_File GDBM_File NDBM_File ODBM_File",
      "-Dloclibpth=#{HOMEBREW_PREFIX}/lib",
      "-Dlocincpth=#{HOMEBREW_PREFIX}/include",
    ]

    args << "-Dusedevel" if build.head?

    system "./Configure", *args
    system "make"
    system "make", "install"
  end

  def post_install
    (hwlib/"#{version.major_minor}").mkpath
  end

  def caveats
    <<~EOS
      By default non-brewed cpan modules are installed to the Cellar. If you wish
      for your modules to persist across updates we recommend using `local::lib`.

      You can set that up like this:
        PERL_MM_OPT="LOCALLIB=~/perl5" cpan local::lib
        echo 'eval "$(perl -I~/perl5/lib/perl5 -Mlocal::lib=~/perl5)"' >> ~/.bash_profile
    EOS
  end

  test do
    system "#{bin}/perl", "-e", "print 'Hello, World!'"
  end
end
