class Blink1 < Formula
  desc "Control blink(1) indicator light"
  homepage "https://blink1.thingm.com/"
  url "https://github.com/todbot/blink1-tool.git",
      tag:      "v2.5.0",
      revision: "600da2c6f14e22fecee0e3871463cdab99a68525"
  license any_of: ["CC-BY-SA-4.0", "MIT"]
  head "https://github.com/todbot/blink1-tool.git", branch: "main"


  on_linux do
    depends_on "pkgconf" => :build
    depends_on "systemd"
  end

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "263488500af99eb6772e316d2ec98a7bfd8a338edff33438f5fddaa34b71d644"
  end

  def install
    # --- 追加缺失库 ---
    ENV.append "LIBS", "-ludev"
    ENV.append "LDFLAGS", "-ludev"
    mkdir_p [bin, include, lib/"pkgconfig"]
    system "make", "LIBS=-ludev"
    system "make", "LIBS=-ludev", "install", "install-dev", "PREFIX=#{prefix}"
  end

  test do
    system bin/"blink1-tool", "--version"
  end
end
