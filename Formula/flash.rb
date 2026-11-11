class Flash < Formula
  desc "Command-line script to flash SD card images of any kind"
  homepage "https://github.com/hypriot/flash"
  url "https://github.com/hypriot/flash/releases/download/2.7.2/flash"
  sha256 "571d9e6424b275859a9273029a2321245888ab201dbae1a3ec57a6ef708adce1"
  license "MIT"



  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "4f4dce0cd401f43e9d5e0eaa2451978b3b2e1e4411a8abd4a0d62656722ffefb"
  end

  def install
    bin.install "flash"
  end

  test do
    cp test_fixtures("test.dmg.gz"), "test.dmg.gz"
    system "gunzip", "test.dmg"
    # This host has hdparm installed, so flash would enter its interactive
    # yes/no prompt. Give the script a PATH containing every command it
    # actually references EXCEPT hdparm, so it deterministically reaches
    # upstream's "not installed" branch (verified against the script source).
    mkdir_p "fakebin"
    %w[awk basename cat cp dd df file grep gzip id ls mount mv rm sed tr
       umount uname xz].each do |cmd|
      path = "/usr/bin/#{cmd}"
      ln_s path, "fakebin/#{cmd}" if File.executable?(path)
    end
    ln_s "/usr/bin/bash", "fakebin/bash"
    ENV["PATH"] = testpath/"fakebin"
    output = pipe_output("#{bin}/flash --device /dev/disk42 test.dmg", "foo\n", 1)
    assert_match "No 'hdparm' command found", output
  end
end
