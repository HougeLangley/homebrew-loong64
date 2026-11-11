class Pacapt < Formula
  desc "Package manager in the style of Arch's pacman"
  homepage "https://github.com/icy/pacapt"
  url "https://github.com/icy/pacapt/archive/refs/tags/v3.0.7.tar.gz"
  sha256 "d1081b639466de7650ed66c7bb5a522482c60c24b03c292c46b86a3983e66234"
  license "Fair"




  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "263742083e182ca3288b2c35ed342b0d9dbadf796f8c533602ac9d270a0e8a0b"
  end

  def install
    bin.mkpath
    system "make", "install", "BINDIR=#{bin}", "VERSION=#{version}"
  end

  test do
    # pacapt 3.0.7's script-name detection tests the full $0 (not basename)
    # for a dash; every Homebrew prefix and mktemp path on this host contains
    # dashes, so absolute invocation dies with "Unable to guess". Copy next to
    # cwd and run via a dash-free relative path so normal system-manager
    # detection runs (dpkg via /usr/bin/apt-get on AOSC).
    cp bin/"pacapt", "pacapt"
    assert_match(/wget/, shell_output("./pacapt -Ss wget"))
  end
end
