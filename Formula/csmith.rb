class Csmith < Formula
  desc "Generates random C programs conforming to the C99 standard"
  homepage "https://github.com/csmith-project/csmith"
  url "https://github.com/csmith-project/csmith/archive/refs/tags/csmith-2.3.0.tar.gz"
  sha256 "9d024a6b202f6a1b9e01351218a85888c06b67b837fe4c6f8ef5bd522fae098c"
  license "BSD-2-Clause"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "cf61da18e6f612f6b5a043d5877fd643e20193a2a623b54ba6cd4807d9fff1b2"
  end

  head "https://github.com/csmith-project/csmith.git", branch: "master"

  livecheck do
    url :stable
    regex(/^(?:csmith[._-])?v?(\d+(?:\.\d+)+)$/i)
  end


  uses_from_macos "m4" => :build

  # Fix -flat_namespace being used on Big Sur and later.
  patch do
    file "Patches/libtool/configure-big_sur.diff"
    type :unofficial
  end

  # Fix build with Clang 21, which no longer downgrades the out-of-range enum cast to a warning
  patch do
    url "https://github.com/csmith-project/csmith/commit/88f99e87cf82be4e9011baf5f4c320e620a60142.patch?full_index=1"
    sha256 "2e10bd42351d4fb097e2fb9d1eb8baecd6118a47dfde686329bb41e0c9624c9d"
    type :backport
    resolves "https://github.com/csmith-project/csmith/pull/165",
             "https://github.com/csmith-project/csmith/issues/177"
  end

  deny_network_access!

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}", "dist/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", *std_configure_args
    system "make"
    system "make", "install"
    mv "#{bin}/compiler_test.in", share
    (include/"csmith-#{version}/runtime").install Dir["runtime/*.h"]
  end

  def caveats
    <<~EOS
      It is recommended that you set the environment variable 'CSMITH_PATH' to
        #{include}/csmith-#{version}
    EOS
  end

  test do
    system bin/"csmith", "-o", "test.c"
  end
end
