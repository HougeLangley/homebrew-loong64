class Codec2 < Formula
  desc "Open source speech codec"
  homepage "https://www.rowetel.com/?page_id=452"
  # Linked from https://freedv.org/
  url "https://github.com/drowe67/codec2/archive/refs/tags/1.2.0.tar.gz"
  sha256 "cbccae52b2c2ecc5d2757e407da567eb681241ff8dadce39d779a7219dbcf449"
  license "LGPL-2.1-only"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
    strategy :git do |tags, regex|
      malformed_tags = ["v1.03"].freeze
      tags.map do |tag|
        next if malformed_tags.include?(tag)

        tag[regex, 1]
      end
    end
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "9c9fb3a292ff399878822ccbb8b5f7bf921018d8769dc6dc98027180e12e4042"
  end

  depends_on "cmake" => :build

  deny_network_access!

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args,
                    "-DCMAKE_EXE_LINKER_FLAGS=-Wl,-rpath,#{rpath}"
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"

    bin.install "build/demo/c2demo"
    bin.install Dir["build/src/c2*"]
  end

  test do
    # 8 bytes of raw audio data (silence).
    (testpath/"test.raw").write([0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00].pack("C*"))
    system bin/"c2enc", "2400", "test.raw", "test.c2"
  end
end
