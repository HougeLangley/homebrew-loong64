class Udunits < Formula
  desc "Unidata unit conversion library"
  homepage "https://docs.unidata.ucar.edu/udunits/current/"
  url "https://downloads.unidata.ucar.edu/udunits/2.2.28/udunits-2.2.28.tar.gz"
  sha256 "590baec83161a3fd62c00efa66f6113cec8a7c461e3f61a5182167e0cc5d579e"
  license "UCAR"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "5d93ad504ce5877dfe216c02384cd85b75d13ca5179878a7cb6a935dc182547d"
  end

  livecheck do
    url "https://downloads.unidata.ucar.edu/udunits/release_info.json"
    strategy :json do |json|
      json["releases"]&.map { |item| item["version"] }
    end
  end


  head do
    url "https://github.com/Unidata/UDUNITS-2.git", branch: "main"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  uses_from_macos "bison" => :build
  uses_from_macos "flex" => :build
  uses_from_macos "expat"

  on_system :linux, macos: :ventura_or_newer do
    depends_on "texinfo" => :build
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "autoreconf", "--force", "--install", "--verbose" if build.head?
    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-silent-rules", *std_configure_args
    system "make", "install"
  end

  test do
    assert_match(/1 kg = 1000 g/, shell_output("#{bin}/udunits2 -H kg -W g"))
  end
end
