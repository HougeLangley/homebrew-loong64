class LcdfTypetools < Formula
  desc "Manipulate OpenType and multiple-master fonts"
  homepage "https://www.lcdf.org/type/"
  url "https://www.lcdf.org/type/lcdf-typetools-2.110.tar.gz"
  sha256 "517f9ee879208679d3224a14d5e6eb20598fc648d5c3562708083d003088a934"
  license "GPL-2.0-or-later"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "98428c51990fcbd02d09ed1a57c0bdb5a8d11f38491a1f733437ebbc70dd81ab"
  end

  head "https://github.com/kohler/lcdf-typetools.git", branch: "master"

  livecheck do
    url :homepage
    regex(/href=.*?lcdf-typetools[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  conflicts_with "texlive", because: "both install a `cfftot1` executable"

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--without-kpathsea"
    system "make", "install"
  end

  test do
    if OS.mac?
      font_path = "/Library/Fonts/Arial Unicode.ttf"
      expected_name = "ArialUnicode"
    else
      candidates = {
        "/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf" => "DejaVuSans",
        "/usr/share/fonts/OTF/FreeSans.otf" => "FreeSans",
      }
      font_path, expected_name = candidates.find { |path, _name| File.exist?(path) }
      refute_nil font_path, "No OpenType font available for the otfinfo test"
    end
    assert_includes shell_output("#{bin}/otfinfo -p '#{font_path}'"), expected_name
  end
end
