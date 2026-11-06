class Crfxx < Formula
  desc "Conditional random fields for segmenting/labeling sequential data"
  homepage "https://taku910.github.io/crfpp/"
  url "https://mirrors.sohu.com/gentoo/distfiles/f2/CRF%2B%2B-0.58.tar.gz"
  mirror "https://drive.google.com/uc?id=1lEwSRLAXpPnlPMPv8fx48y13Xy5eHNU9&export=download"
  sha256 "9d1c0a994f25a5025cede5e1d3a687ec98cd4949bfb2aae13f2a873a13259cb2"
  license any_of: ["LGPL-2.1-only", "BSD-3-Clause"]
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "8c2ba0b093f60c03fb2c0fd7ca94f16e3181d55f1aeb18eda1723ef946db492c"
  end

  head "https://github.com/taku910/crfpp.git", branch: "master"

  # Archive files from upstream are hosted on Google Drive, so we can't identify
  # versions from the tarballs, as the links on the homepage don't include this
  # information. This identifies versions from the "News" sections, which works
  # for now but may encounter issues in the future due to the loose regex.
  livecheck do
    url :homepage
    regex(/CRF\+\+ v?(\d+(?:\.\d+)+)[\s<]/i)
  end


  # Fix -flat_namespace being used on Big Sur and later.
  patch do
    file "Patches/libtool/configure-pre-0.4.2.418-big_sur.diff"
    type :unofficial
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

    args = []
    # Help old config scripts identify arm64 linux
    args << "--build=aarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    args << "--build=loongarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arch == :loongarch64

    system "./configure", *args, *std_configure_args
    system "make", "CXXFLAGS=#{ENV.cflags}", "install"
  end

  test do
    # Using "; true" because crf_test -v and -h exit nonzero under normal operation
    output = shell_output("#{bin}/crf_test --help; true")
    assert_match "CRF++: Yet Another CRF Tool Kit", output
  end
end
