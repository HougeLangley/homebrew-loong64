class Freediameter < Formula
  desc "Open source Diameter (Authentication) protocol implementation"
  homepage "https://github.com/freeDiameter/freeDiameter"
  url "https://github.com/freeDiameter/freeDiameter/archive/refs/tags/1.6.0.tar.gz"
  sha256 "0bb4ed33ada0b57ab681d86ae3fe0e3a9ce95892f492c401cbb68a87ec1d47bc"
  license "BSD-3-Clause"
  head "https://github.com/freeDiameter/freeDiameter.git", branch: "master"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end


  bottle do
    rebuild 3
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "9baa824cd00351d80ee2ef1d7e27f14d551c0086ea12643b95274d7c752b9327"
  end

  depends_on "cmake" => :build
  depends_on "pkgconf" => :build
  depends_on "gnutls"
  depends_on "libgcrypt"
  depends_on "libidn2"

  uses_from_macos "bison" => :build
  uses_from_macos "flex" => :build

  # cmake rpath patch
  patch do
    url "https://github.com/freeDiameter/freeDiameter/commit/3037ee7735b969d106b197818c1a5bcdb4586d77.patch?full_index=1"
    sha256 "146a8e6586b1a1146f06771129609583d43a792bbd94eea7a3c0348f02eb26b2"
    type :unofficial
    resolves "https://github.com/freeDiameter/freeDiameter/pull/84"
  end

  deny_network_access!

  def install
    args = %W[
      -DDEFAULT_CONF_PATH=#{etc}
      -DDISABLE_SCTP=ON
    ]
    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"

    cp "doc/freediameter.conf.sample", "freeDiameter.conf"
    etc.install "freeDiameter.conf"
    doc.install Dir["doc/*"]
    pkgshare.install "contrib"
  end

  def caveats
    <<~EOS
      To configure freeDiameter, edit #{etc}/freeDiameter.conf to taste.

      Sample configuration files can be found in #{doc}.

      For more information about freeDiameter configuration options, read:
        http://www.freediameter.net/trac/wiki/Configuration

      Other potentially useful files can be found in #{opt_pkgshare}/contrib.
    EOS
  end

  service do
    run opt_bin/"freeDiameterd"
    keep_alive true
    require_root true
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/freeDiameterd --version")
  end
end
