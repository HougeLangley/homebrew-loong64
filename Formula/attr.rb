class Attr < Formula
  desc "Manipulate filesystem extended attributes"
  homepage "https://savannah.nongnu.org/projects/attr"
  url "https://download.savannah.nongnu.org/releases/attr/attr-2.6.0.tar.gz"
  mirror "https://mirror.csclub.uwaterloo.ca/nongnu/attr/attr-2.6.0.tar.gz"
  sha256 "d42fa374513180bb48cb11a46696f488240e5124ff1e6ad88b0abff706985612"
  license "GPL-2.0-or-later"

  livecheck do
    url "https://download.savannah.nongnu.org/releases/attr/"
    regex(/href=.*?attr[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 arm64_linux:  "6cf6153b6390b7efb17d220b68e7ca26afab6778d4db7c7fc1da71029198df5c"
    sha256 x86_64_linux: "fbb8da02d151687a0ff9c27add3f0600dad7717b44e03160800afbcf0ea9f291"
  end

  depends_on :linux

  deny_network_access!

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-silent-rules", *std_configure_args
    system "make", "install"
  end

  test do
    (testpath/"test.txt").write("Hello World!\n")
    output = pipe_output("#{bin}/attr -s name test.txt", "", 0)
    assert_match 'Attribute "name" set to a 0 byte value for test.txt', output
    output = shell_output("#{bin}/attr -l test.txt")
    assert_match 'Attribute "name" has a 0 byte value for test.txt', output
  end
end
