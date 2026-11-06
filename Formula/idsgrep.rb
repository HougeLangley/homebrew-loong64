class Idsgrep < Formula
  desc "Grep for Extended Ideographic Description Sequences"
  homepage "https://tsukurimashou.org/idsgrep.php.en"
  url "https://tsukurimashou.org/files/idsgrep-0.6.tar.gz"
  sha256 "2c07029bab12d9ceefddf447ce4213535b68d020b093a593190c2afa8a577c7c"
  license "GPL-3.0-only"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "0a12c95bae4f28a073f0ed1d7e4619d340ebd02bc3a5141cd007ab168b573009"
  end

  livecheck do
    url :homepage
    regex(/href=.*idsgrep[._-]v?(\d+(?:\.\d+)+)\.t*/i)
  end


  depends_on "cmake" => :build

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-silent-rules",
                          "--without-pcre",
                          *std_configure_args.reject { |arg| arg["--libdir"] }
    system "make", "install"
    pkgshare.install "chise.eids"
  end

  test do
    expected = <<~EOS
      【䲤】⿰⻥<酒>⿰氵酉
      【酒】⿰氵酉
      【鿐】⿰魚<酒>⿰氵酉
      【𤄍】⿰<酒>⿰氵酉<留>⿱<CDP-8C69>⿰<CDP-88EE>;刀田
      【𦵩】⿱艹<酒>⿰氵酉
      【𫇓】⿳⿴𦥑<林>⿰木木冖<酒>⿰氵酉
      【𬜂】⿱⿴𦥑<林>⿰木木<酒>⿰氵酉
      【𭊼】⿱<酒>⿰氵酉<吒>⿰口<乇>⿱丿七
      【𭳒】⿰<酒>⿰氵酉<或>⿹戈<CDP-8BE2>⿱口一
    EOS
    assert_equal expected, shell_output("#{bin}/idsgrep -dk '...酒' #{pkgshare}/chise.eids")
  end
end
