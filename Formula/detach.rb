class Detach < Formula
  desc "Execute given command in detached process"
  homepage "https://inglorion.net/software/detach/"
  url "https://inglorion.net/download/detach-0.2.3.tar.bz2"
  sha256 "b2070e708d4fe3a84197e2a68f25e477dba3c2d8b1f9ce568f70fc8b8e8a30f0"
  license "MIT"

  livecheck do
    url :homepage
    regex(/href=.*?detach[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "f70e3952270db1b65033a532e93045c0bb3076e76abcba6c2da51de5b99f24a9"
  end

  def install
    system "make", "install", "PREFIX=#{prefix}"
    bin.install "detach"
    man1.install "detach.1"
  end

  test do
    system bin/"detach", "-p", testpath/"pid", "sh", "-c", "sleep 10"
    pid = (testpath/"pid").read.to_i
    ppid = shell_output("ps -p #{pid} -o ppid=").to_i
    assert_equal 1, ppid
    Process.kill "TERM", pid
  end
end
