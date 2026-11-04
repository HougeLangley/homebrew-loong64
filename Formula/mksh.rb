class Mksh < Formula
  desc "MirBSD Korn Shell"
  homepage "https://mbsd.evolvis.org/mksh.htm"
  url "https://mbsd.evolvis.org/MirOS/dist/mir/mksh/mksh-R59c.tgz"
  version "59c"
  sha256 "77ae1665a337f1c48c61d6b961db3e52119b38e58884d1c89684af31f87bc506"
  license "MirOS"

  livecheck do
    url "https://mbsd.evolvis.org/MirOS/dist/mir/mksh/"
    regex(/href=.*?mksh-R?(\d+[a-z]?)\.t/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "5503f69c86b6c9134a76e21e098054ca9f8b182103ee99a5862167b20274c00a"
  end

  def install
    system "sh", "./Build.sh", "-r"
    bin.install "mksh"
    man1.install "mksh.1"
  end

  test do
    assert_equal "honk",
      shell_output("#{bin}/mksh -c 'echo honk'").chomp
  end
end
