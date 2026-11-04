class Rolldice < Formula
  desc "Rolls an amount of virtual dice"
  homepage "https://github.com/sstrickl/rolldice"
  url "https://github.com/sstrickl/rolldice/archive/refs/tags/v1.16.tar.gz"
  sha256 "8bc82b26c418453ef0fe79b43a094641e7a76dae406032423a2f0fb270930775"
  license "GPL-2.0-only"

  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "31cbdac9770c8b9b8d42c6a3adb157b9df62dfaa4d247483971aa03cbc679c71"
  end


  uses_from_macos "libedit" # readline's license is incompatible with GPL-2.0-only

  # Submitted upstream; remove if merged and included in a tagged release
  patch do
    url "https://github.com/sstrickl/rolldice/commit/5e53bade81d0fc972857889c1b690dcd830b439b.patch?full_index=1"
    sha256 "133214dcc8c8d8e4620205273c6c932cc0674e11717bf4b2fa432a205e825cc5"
    type :unofficial
    resolves "https://github.com/sstrickl/rolldice/pull/25"
  end


  def install
    unless OS.mac?
      ENV.append_to_cflags "-I#{formula_opt_libexec("libedit")}/include"
      ENV.append "LDFLAGS", "-L#{formula_opt_libexec("libedit")}/lib"
    end

    system "make", "CC=#{ENV.cc}"
    bin.install "rolldice"
    man6.install Utils::Gzip.compress("rolldice.6")
  end

  test do
    assert_match "Roll #1", shell_output("#{bin}/rolldice -s 1x2d6")
  end
end
