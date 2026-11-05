class Tivodecode < Formula
  desc "Convert .tivo to .mpeg"
  homepage "https://tivodecode.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/tivodecode/tivodecode/0.2pre4/tivodecode-0.2pre4.tar.gz"
  sha256 "788839cc4ad66f5b20792e166514411705e8564f9f050584c54c3f1f452e9cdf"
  # The `:cannot_represent` is for the Turing encryption algorithm under a non-SPDX
  # QUALCOMM license which has similar restrictions to BSD-Systemics along with an
  # additional clause relating to the use of patented encryption algorithms.
  license all_of: ["BSD-3-Clause", :cannot_represent]

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "7a23eca3340d0b1f40d2734a42bd13498a78c04d5f3d1affb535ee0c0689a103"
  end

  livecheck do
    url :stable
    regex(%r{url=.*?/tivodecode[._-]v?(\d+(?:\.\d+)+(?:pre\d+)?)\.t}i)
  end


  deny_network_access!

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", *std_configure_args
    system "make", "install"
  end

  test do
    # Build a minimal TiVo file: 16-byte header, an XML chunk (key material),
    # an encrypted metadata chunk (id 1) and an unscrambled MPEG payload.
    tivo_file = lambda do |blob, payload|
      xml = '<?xml version="1.0"?><TvBusMarshalledStruct/>'
      chunks = [12 + xml.bytesize, xml.bytesize, 3, 0].pack("NNnn") + xml
      chunks += [12 + blob.bytesize, blob.bytesize, 1, 1].pack("NNnn") + blob
      ["TiVo", 4, 0x0d, 0, 16 + chunks.bytesize, 2].pack("a4nnnNn") + chunks + payload
    end

    (testpath/"plain.tivo").binwrite tivo_file.call("Homebrew metadata", "Homebrew TiVo payload\n")
    system bin/"tivodecode", "-m", "0123456789", "-o", "out.mpg", "plain.tivo"
    assert_equal "Homebrew TiVo payload\n", (testpath/"out.mpg").read

    # Turing is a stream cipher, so applying it twice restores the plaintext
    system bin/"tdcat", "-m", "0123456789", "-o", "enc.bin", "plain.tivo"
    encrypted = (testpath/"enc.bin").binread
    assert_equal "4f9f31fa29f8ee340da8413225fe5dd6e5", encrypted.unpack1("H*")

    (testpath/"enc.tivo").binwrite tivo_file.call(encrypted, "")
    system bin/"tdcat", "-m", "0123456789", "-o", "dec.bin", "enc.tivo"
    assert_equal "Homebrew metadata", (testpath/"dec.bin").read
  end
end
