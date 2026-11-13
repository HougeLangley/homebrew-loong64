class Pit < Formula
  desc "Project manager from hell (integrates with Git)"
  homepage "https://github.com/michaeldv/pit"
  license "BSD-2-Clause"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "a011a25407969ef9a9816b9468af767997576b7e21f4a154e16d0176fe6ce6e6"
  end

  head "https://github.com/michaeldv/pit.git", branch: "master"

  # upstream commit to allow PREFIX-ed installs
  stable do
    url "https://github.com/michaeldv/pit/archive/refs/tags/0.1.0.tar.gz"
    sha256 "ddf78b2734c6dd3967ce215291c3f2e48030e0f3033b568eb080a22f041c7a0e"

    patch do
      url "https://github.com/michaeldv/pit/commit/f64978d6c2628e1d4897696997b551f6b186d4bc.patch?full_index=1"
      sha256 "f97a553bc5ca0eddf379e3ca3f96374508f8627e18aaff846786c41d7ba1987b"
      type :backport
      resolves "https://github.com/michaeldv/pit/pull/2"
    end

    # upstream commit to fix a segfault when using absolute paths
    patch do
      url "https://github.com/michaeldv/pit/commit/e378582f4d04760d1195675ab034aac5d7908d8d.patch?full_index=1"
      sha256 "73651472d98aa02e58fbf6f1cc4ce29100616d6f6d155907c4680eb73217f43f"
      type :backport
      resolves "https://github.com/michaeldv/pit/issues/4"
    end

    # upstream commit to return 0 on success instead of 1
    patch do
      url "https://github.com/michaeldv/pit/commit/5d81148349cc442d81cc98779a4678f03f59df67.patch?full_index=1"
      sha256 "3ae9004fe9551ab51be44df2195bf5e373e1473a888c11601de0d046322d382f"
      type :backport
      resolves "https://github.com/michaeldv/pit/pull/6"
    end
  end


  uses_from_macos "ruby"

  def install
    ENV.deparallelize
    bin.mkpath

    # GCC 15+ defaults to C23: bool is a built-in keyword, and () means an
    # actual zero-argument prototype rather than an unspecified argument list.
    inreplace "src/pit.h", "typedef int bool;", "#include <stdbool.h>"
    inreplace "src/pit.h", "void pit_version();", "void pit_version(char *argv[]);"
    inreplace "src/help.c", "pit_version();", "pit_version(NULL);"
    system "make"
    system "make", "test"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    system bin/"pit", "init"
  end
end
