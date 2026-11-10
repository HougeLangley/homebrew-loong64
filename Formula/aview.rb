class Aview < Formula
  desc "ASCII-art image browser and animation viewer"
  homepage "https://aa-project.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/aa-project/aview/1.3.0rc1/aview-1.3.0rc1.tar.gz"
  sha256 "42d61c4194e8b9b69a881fdde698c83cb27d7eda59e08b300e73aaa34474ec99"
  license "GPL-2.0-only"

  livecheck do
    url :stable
    regex(%r{url=.*?/aview[._-]v?(\d+(?:\.\d+)+(?:[a-z]+\d*)?)\.t}i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "6ba08869ac7df3d4364c1ab9683c0b27141b406ed8e522cfd07f7a2837ebf00c"
  end

  depends_on "aalib"

  patch do
    file "Patches/aview/1.3.0rc1.patch"
    type :unofficial
  end

  deny_network_access!

  def install
    # The absolute wrapper appends GCC 16 compatibility flags to every
    # configure probe and make compile without replacing Makefile variables.
    cc = "/home/houge/infra/ci/bin/cc-compat"
    cxx = "/home/houge/infra/ci/bin/cxx-compat"
    %w[config.sub config.guess].each do |name|
      source = "/usr/share/libtool/build-aux/#{name}"
      cp source, name if File.exist?(name) && File.exist?(source)
    end
    ENV["CC"] = cc
    ENV["CXX"] = cxx
    system("./configure",
           "--build=loongarch64-unknown-linux-gnu",
           "--disable-debug", "--disable-dependency-tracking",
           "--prefix=#{prefix}", "--mandir=#{man}")
    system "make", "CC=#{cc}", "CXX=#{cxx}", "install"
  end

  test do
    system bin/"aview", "--version"
  end
end
