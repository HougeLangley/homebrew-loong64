class Chuck < Formula
  desc "Concurrent, on-the-fly audio programming language"
  homepage "https://chuck.cs.princeton.edu/"
  url "https://chuck.cs.princeton.edu/release/files/chuck-1.5.5.8.tgz"
  mirror "https://chuck.stanford.edu/release/files/chuck-1.5.5.8.tgz"
  sha256 "d230f74cea1b0454ccfae4b2fedfb27ea20e6250c7130f079fa4195fef1f304a"
  license "GPL-2.0-or-later"
  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "9ac50907d8eec2bae42bd6b9ada22f222ca09cd12c95ee24845c993d3559d342"
  end

  head "https://github.com/ccrma/chuck.git", branch: "main"

  livecheck do
    url "https://chuck.cs.princeton.edu/release/files/"
    regex(/href=.*?chuck[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  uses_from_macos "bison" => :build
  uses_from_macos "flex" => :build

  on_linux do
    depends_on "alsa-lib"
    depends_on "libsndfile"
    depends_on "pulseaudio"
  end


  def install
    os = OS.mac? ? "mac" : "linux-pulse"
    system "make", "-C", "src", os
    bin.install "src/chuck"
    pkgshare.install "examples"
  end

  test do
    (testpath/"test.ck").write("<<< 2 + 3 >>>;\n")
    assert_match "5 :(int)", shell_output("#{bin}/chuck --silent #{testpath}/test.ck 2>&1")
  end
end
