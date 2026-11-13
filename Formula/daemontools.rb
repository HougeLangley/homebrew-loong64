class Daemontools < Formula
  desc "Collection of tools for managing UNIX services"
  homepage "https://cr.yp.to/daemontools.html"
  url "https://cr.yp.to/daemontools/daemontools-0.76.tar.gz"
  sha256 "a55535012b2be7a52dcd9eccabb9a198b13be50d0384143bd3b32b8710df4c1f"
  license :public_domain
  revision 2

  livecheck do
    url "https://cr.yp.to/daemontools/install.html"
    regex(/href=.*?daemontools[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "939d8d45a318f27edfbfeb149bdb395c3f5b18f57cc821c89efbef3f5b51be35"
  end

  resource "man" do
    url "https://deb.debian.org/debian/pool/main/d/daemontools/daemontools_0.76-8.1.debian.tar.xz"
    sha256 "b9a1ed0ea88172d921738237c48e67cbe3b04e5256fea8ec00f32116c9ef74c0"
  end

  # Fix build failure due to missing #include <errno.h> on Linux.
  # Patch submitted to author by email.
  patch do
    file "Patches/daemontools/errno.patch"
    type :unofficial
  end

  # Fix build failure due to missing headers for POSIX-related functions.
  patch do
    file "Patches/daemontools/posix-headers.patch"
    type :unofficial
  end

  def install
    cd "daemontools-#{version}" do
      # djb's compile script reads src/conf-cc verbatim. Add a modern C
      # dialect so old-style prototypes remain compatible with glibc.
      inreplace "src/conf-cc" do |s|
        s.gsub!(/^(\S+)/, '\1 -std=gnu17 -Wno-error=incompatible-pointer-types -Wno-error=implicit-function-declaration')
      end

      inreplace ["package/run", "src/svscanboot.sh"] do |s|
        s.gsub! "/service", "#{etc}/service"
        s.gsub! "/command", bin.to_s
      end

      # Work around build error from root requirement: "Oops. Your getgroups() returned 0,
      # and setgroups() failed; this means that I can't reliably do my shsgr test. Please
      # either ``make'' as root or ``make'' while you're in one or more supplementary groups."
      inreplace "src/Makefile", "( cat warn-shsgr; exit 1 )", "cat warn-shsgr" if OS.linux?

      system "package/compile"
      bin.install Dir["command/*"]
    end

    resource("man").stage do
      man8.install Dir["daemontools-man/*.8"]
    end
  end

  post_install_steps do
    mkdir_p "service", base: :etc
  end

  def caveats
    <<~EOS
      Services are stored in:
        #{etc}/service/
    EOS
  end

  service do
    run opt_bin/"svscanboot"
    keep_alive true
    require_root true
  end

  test do
    assert_match "Homebrew", shell_output("#{bin}/softlimit -t 1 echo 'Homebrew'")
  end
end
