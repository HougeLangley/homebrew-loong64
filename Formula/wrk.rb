class Wrk < Formula
  desc "HTTP benchmarking tool"
  homepage "https://github.com/wg/wrk"
  url "https://github.com/wg/wrk/archive/refs/tags/4.2.0.tar.gz"
  sha256 "e255f696bff6e329f5d19091da6b06164b8d59d62cb9e673625bdcd27fe7bdad"
  # License is modified Apache 2.0 with addition to Section 4 Redistribution:
  #
  # (e) If the Derivative Work includes substantial changes to features
  #     or functionality of the Work, then you must remove the name of
  #     the Work, and any derivation thereof, from all copies that you
  #     distribute, whether in Source or Object form, except as required
  #     in copyright, patent, trademark, and attribution notices.
  license :cannot_represent
  revision 2
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "c4b62d5305d84a06a1d67606975c3d7a88f817f7e565acb7055b736230c4e20a"
  end

  head "https://github.com/wg/wrk.git", branch: "master"



  depends_on "luajit"
  depends_on "openssl@4"

  allow_network_access! :test

  def install
    ENV.deparallelize
    ENV["MACOSX_DEPLOYMENT_TARGET"] = MacOS.version.to_s if OS.mac?
    ENV.append_to_cflags "-I#{formula_opt_include("luajit")}/luajit-2.1"
    args = %W[
      WITH_LUAJIT=#{formula_opt_prefix("luajit")}
      WITH_OPENSSL=#{formula_opt_prefix("openssl@4")}
    ]
    args << "VER=#{version}" if build.stable?
    system "make", *args
    bin.install "wrk"
  end

  test do
    system bin/"wrk", "-c", "1", "-t", "1", "-d", "1", "https://example.com/"
  end
end
