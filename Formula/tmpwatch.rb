class Tmpwatch < Formula
  desc "Find and remove files not accessed in a specified time"
  homepage "https://pagure.io/tmpwatch"
  # Fedora's content-addressed lookaside preserves the original tarball and SHA-256.
  url "https://src.fedoraproject.org/repo/pkgs/tmpwatch/tmpwatch-2.11.tar.bz2/9ea7e169296eb1196b80fe05bba1cbd0/tmpwatch-2.11.tar.bz2"
  sha256 "93168112b2515bc4c7117e8113b8d91e06b79550d2194d62a0c174fe6c2aa8d4"
  license "GPL-2.0-only"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "833ba7a2d58ed40e1c3d89c4becbd7aa095a8619aedfc472d2b6ad5b79b4307c"
  end

  head "https://pagure.io/tmpwatch.git", branch: "master"

  livecheck do
    url :head
    regex(/^(?:r|tmpwatch|v)[._-]?(\d+(?:[._-]\d+)+)$/i)
    strategy :git do |tags|
      tags.filter_map { |tag| tag[regex, 1]&.gsub(/[_-]/, ".") }
    end
  end


  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    mkdir "test" do
      touch %w[a b c]
      ten_minutes_ago = Time.now - 600
      File.utime(ten_minutes_ago, ten_minutes_ago, "a")
      system sbin/"tmpwatch", "2m", Pathname.pwd
      assert_equal %w[b c], Dir["*"]
    end
  end
end
