class Sha1dc < Formula
  desc "Tool to detect SHA-1 collisions in files, including SHAttered"
  homepage "https://github.com/cr-marcstevens/sha1collisiondetection"
  url "https://github.com/cr-marcstevens/sha1collisiondetection/archive/refs/tags/stable-v1.0.3.tar.gz"
  sha256 "77a1c2b2a4fbe4f78de288fa4831ca63938c3cb84a73a92c79f436238bd9ac07"
  license "MIT"

  # The "master" branch is unusably broken and behind the
  # "simplified_c90" branch that's the basis for release.
  head "https://github.com/cr-marcstevens/sha1collisiondetection.git", branch: "master"

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "c7c1ba9035f3efe032e74b2f3ba67e0db730f44718911ca8f66f9abde7c8bf4d"
  end



  depends_on "coreutils" => :build # GNU install
  depends_on "libtool" => :build

  def install
    system "make", "INSTALL=ginstall", "PREFIX=#{prefix}", "install"
    (pkgshare/"test").install Dir["test/*"]
  end

  test do
    assert_match "*coll*", shell_output("#{bin}/sha1dcsum #{pkgshare}/test/shattered-1.pdf")
    assert_match "*coll*", shell_output("#{bin}/sha1dcsum #{pkgshare}/test/shattered-2.pdf")
    assert_match "*coll*", shell_output("#{bin}/sha1dcsum_partialcoll #{pkgshare}/test/sha1_reducedsha_coll.bin")
  end
end
