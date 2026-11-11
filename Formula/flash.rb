class Flash < Formula
  desc "Command-line script to flash SD card images of any kind"
  homepage "https://github.com/hypriot/flash"
  url "https://github.com/hypriot/flash/releases/download/2.7.2/flash"
  sha256 "571d9e6424b275859a9273029a2321245888ab201dbae1a3ec57a6ef708adce1"
  license "MIT"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "ce3e9f777da12f1408dd831585bf3b95564fa8b706d8082b983e8f2fc6c4fd69"
  end

  def install
    bin.install "flash"
  end

  test do
    cp test_fixtures("test.dmg.gz"), "test.dmg.gz"
    system "gunzip", "test.dmg"
    # This host has hdparm installed, so flash would enter its interactive
    # yes/no prompt. Hide hdparm behind a PATH that only provides bash
    # (flash is an `env bash` script), matching upstream CI where hdparm
    # is absent and the deterministic "not installed" path is tested.
    mkdir_p "fakebin"
    ln_s "/usr/bin/bash", "fakebin/bash"
    ENV["PATH"] = testpath/"fakebin"
    output = pipe_output("#{bin}/flash --device /dev/disk42 test.dmg", "foo\n", 1)
    assert_match "No 'hdparm' command found", output
  end
end
