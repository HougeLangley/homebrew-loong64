class Icon < Formula
  desc "General-purpose programming language"
  homepage "https://www2.cs.arizona.edu/icon/"
  url "https://github.com/gtownsend/icon/archive/refs/tags/v9.5.25a.tar.gz"
  version "9.5.25a"
  sha256 "ab15b7fc5a96e8b4da1b76cc6c7935400879f8a54b0fcf94a947c02815f21006"
  license :public_domain

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+[a-z]?)$/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "4744bafab870dc811f1911735aca30465e777f7566043514835c1cdc7d1fd8ed"
  end

  def install
    ENV.deparallelize
    target = if OS.mac?
      "macintosh"
    else
      "linux"
    end
    system "make", "Configure", "name=#{target}"
    system "make"
    bin.install "bin/icon", "bin/icont", "bin/iconx"
    doc.install Dir["doc/*"]
    man1.install Dir["man/man1/*.1"]
  end

  test do
    args = "'procedure main(); writes(\"Hello, World!\"); end'"
    output = shell_output("#{bin}/icon -P #{args}")
    assert_equal "Hello, World!", output
  end
end
