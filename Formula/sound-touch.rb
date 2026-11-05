class SoundTouch < Formula
  desc "Audio processing library"
  homepage "https://www.surina.net/soundtouch/"
  url "https://codeberg.org/soundtouch/soundtouch/archive/2.4.1.tar.gz"
  sha256 "35d404e6e8c2ebd12fb4000da6fadd75c99e37eed2126a04721828c11c0377ec"
  license "LGPL-2.1-or-later"

  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "7352539d9c327aeedabeeac0122ea12c7b0bceb5da962b84b22de4e1fec25850"
  end



  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  def install
    ENV.append "CXXFLAGS", "-std=c++14"

    system "/bin/sh", "bootstrap"
    args = %W[
      --disable-dependency-tracking
      --disable-silent-rules
      --prefix=#{prefix}
    ]

    system "./configure", *args
    system "make", "install"
  end

  test do
    assert_match "SoundStretch v#{version} -", shell_output("#{bin}/soundstretch 2>&1", 255)
  end
end
