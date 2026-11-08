class Bwfmetaedit < Formula
  desc "Tool for embedding, validating, and exporting BWF file metadata"
  homepage "https://mediaarea.net/BWFMetaEdit"
  url "https://mediaarea.net/download/binary/bwfmetaedit/26.08.1/BWFMetaEdit_CLI_26.08.1_GNU_FromSource.tar.xz"
  sha256 "6650b61fab0bd752b907fda5ca3bdce5bb349e12d9a6f618e8ebfc52839bbd1f"
  license "0BSD"

  livecheck do
    url "https://mediaarea.net/BWFMetaEdit/Download/Source"
    regex(/href=.*?bwfmetaedit[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  deny_network_access!

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "3e9049a750a8210a7524638c7142d6b1b973b1a5cc2a191cb0170f914feb7c82"
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    cd "Project/GNU/CLI" do
      system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-debug", "--prefix=#{prefix}"
      system "make", "install"
    end
  end

  test do
    test_wav = test_fixtures("test.wav")
    output = shell_output("#{bin}/bwfmetaedit --out-tech #{test_wav} 2>&1", 1)
    assert_match "FileName,FileSize,DateCreated,DateModified,Format,CodecID,Channels,SampleRate,BitRate", output
    assert_match "#{test_wav}: Is read only", output
  end
end
