class VisionmediaWatch < Formula
  desc "Periodically executes the given command"
  homepage "https://github.com/tj/watch"
  url "https://github.com/tj/watch/archive/refs/tags/0.4.0.tar.gz"
  sha256 "d37ead189a644661d219b566170122b80d44f235c0df6df71b2b250f3b412547"
  license "MIT"
  head "https://github.com/tj/watch.git", branch: "master"


  conflicts_with "watch"

  deny_network_access!

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "c181f44bad0b5428522b4aa4c86f80d34ee731af56117a160190677940109f27"
  end

  def install
    bin.mkdir
    system "make", "PREFIX=#{prefix}", "install"
  end

  test do
    # Run the command every 10ms and halt (-x) once it fails on the third iteration
    cmd = "echo run >> log; echo iteration; test $(wc -l < log) -lt 3 || exit 42"
    output = shell_output("#{bin}/watch -x -i 10ms '#{cmd}' 2>&1", 42)
    assert_equal 3, output.scan("iteration").size
    assert_match "exit: 42", output
    assert_equal "run\n" * 3, (testpath/"log").read
  end
end
