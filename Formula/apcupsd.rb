class Apcupsd < Formula
  desc "Daemon for controlling APC UPSes"
  homepage "http://www.apcupsd.org"
  url "https://downloads.sourceforge.net/project/apcupsd/apcupsd%20-%20Stable/3.14.14/apcupsd-3.14.14.tar.gz"
  sha256 "db7748559b6b4c3784f9856561ef6ac6199ef7bd019b3edcd7e0a647bf8f9867"
  license "GPL-2.0-only" # a few files have "or later", but most do not

  livecheck do
    url :stable
    regex(%r{url=.*?/apcupsd%20-%20Stable/[^/]+/apcupsd[._-]v?(\d+(?:\.\d+)+)\.t}i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "e5905dd4cbbe6e36c77e67088d5c94d4567d4c2001c76e0198799a832fe8b2ae"
  end

  depends_on "gd"
  depends_on "libusb-compat"

  on_linux do
    depends_on "systemd" # for shutdown
  end

  deny_network_access!

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "buildaux/#{cf}", "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}", "dist/#{cf}"].each do |rel|
        src = "/usr/share/libtool/build-aux/#{cf}"
        dest = buildpath/rel
        if dest.exist? && File.exist?(src)
          File.chmod(0644, dest)
          cp src, dest
        end
      end
    end

    ENV.prepend_path "PATH", Formula["systemd"].opt_sbin if OS.linux?
    sysconfdir = etc/name
    args = %W[
      --prefix=#{prefix}
      --sbindir=#{sbin}
      --sysconfdir=#{sysconfdir}
      --enable-cgi
      --with-cgi-bin=#{sysconfdir}
      --enable-usb
      --enable-modbus-usb
    ]

    if OS.mac?
      # Detecting the lack of gethostname_r() goes wrong on Xcode 12:
      args << "ac_cv_func_which_gethostbyname_r=no"

      # Paths below are hard-coded upstream for creation of `.pkg` installer.

      # Install apcagent.app to `prefix`.
      inreplace "src/apcagent/Makefile", "Applications", prefix

      cd "platforms/darwin" do
        inreplace "Makefile" do |s|
          # Install launch daemon and kernel extension to subdirectories of `prefix`.
          s.gsub! "/Library/LaunchDaemons", lib/"Library/LaunchDaemons"
          s.gsub! "/System/Library/Extensions", kext_prefix
          # Custom uninstaller not needed as this is handled by Homebrew.
          s.gsub!(/.*apcupsd-uninstall.*/, "")
        end

        # Use appropriate paths for launch daemon and launch script.
        inreplace %w[apcupsd-start.in org.apcupsd.apcupsd.plist.in], "/etc/apcupsd", sysconfdir
      end
    else
      # Avoid Linux distro-specific paths
      args << "--with-distname=unknown"
      args << "--with-halpolicydir=#{share}/hal/fdi/policy/20thirdparty"
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", *args
    system "make", "install"
  end

  def caveats
    on_macos do
      <<~EOS
        For #{name} to be able to communicate with UPSes connected via USB,
        the kernel extension must be installed by the root user:

          sudo cp -pR #{kext_prefix}/ApcupsdDummy.kext /System/Library/Extensions/
          sudo chown -R root:wheel /System/Library/Extensions/ApcupsdDummy.kext
          sudo touch /System/Library/Extensions/

          Note: The kernel extension currently does not work as expected.

          You will have to unplug and plug the USB cable back in after each
          reboot in order for #{name} to be able to connect to the UPS.

        To load #{name} at startup, activate the included Launch Daemon:

          sudo cp #{prefix}/lib/Library/LaunchDaemons/org.apcupsd.apcupsd.plist /Library/LaunchDaemons
          sudo chmod 644 /Library/LaunchDaemons/org.apcupsd.apcupsd.plist
          sudo launchctl load -w /Library/LaunchDaemons/org.apcupsd.apcupsd.plist

        If this is an upgrade and you already have the Launch Daemon loaded, you
        have to unload the Launch Daemon before reinstalling it:

          sudo launchctl unload -w /Library/LaunchDaemons/org.apcupsd.apcupsd.plist
          sudo rm /Library/LaunchDaemons/org.apcupsd.apcupsd.plist
      EOS
    end
  end

  test do
    system sbin/"apcupsd", "--version"
    assert_match "usage", shell_output("#{sbin}/apctest --help", 1)
  end
end
