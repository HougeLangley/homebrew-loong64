class BpmTools < Formula
  desc "Detect tempo of audio files using beats-per-minute (BPM)"
  homepage "https://www.pogo.org.uk/~mark/bpm-tools/"
  url "https://www.pogo.org.uk/~mark/bpm-tools/releases/bpm-tools-0.3.tar.gz"
  sha256 "37efe81ef594e9df17763e0a6fc29617769df12dfab6358f5e910d88f4723b94"
  license "GPL-2.0-only"
  head "https://www.pogo.org.uk/~mark/bpm-tools.git", branch: "master"

  livecheck do
    url :homepage
    regex(/href=.*?bpm-tools[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "b1670b8df2eb1bc97e237ede2c3f4d23d7d377f8467d630e78473098b79c491c"
  end

  def install
    system "make"
    bin.install "bpm"
    bin.install "bpm-tag"
  end

  test do
    assert_match "/dev/null: file extension not known", shell_output("#{bin}/bpm-tag /dev/null 2>&1", 1)
  end
end
