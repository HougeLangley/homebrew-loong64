class Flash < Formula
  desc "Command-line script to flash SD card images of any kind"
  homepage "https://github.com/hypriot/flash"
  url "https://github.com/hypriot/flash/releases/download/2.7.2/flash"
  sha256 "571d9e6424b275859a9273029a2321245888ab201dbae1a3ec57a6ef708adce1"
  license "MIT"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "8af3cba0539d311fef0892777c3a7160825b06d4cbb77baa869b8f1732e1e65f"
  end

  def install
    bin.install "flash"
  end

  test do
    cp test_fixtures("test.dmg.gz"), "test.dmg.gz"
    system "gunzip", "test.dmg"
    output = pipe_output("#{bin}/flash --device /dev/disk42 test.dmg", "foo\n", 1)
    # On Linux, need `hdparm` installed by system package manager as it is run
    # via `sudo` which will not have Homebrew's bin in PATH.
    expected = OS.mac? ? "Please answer yes or no." : "No 'hdparm' command found"
    assert_match expected, output
  end
end
