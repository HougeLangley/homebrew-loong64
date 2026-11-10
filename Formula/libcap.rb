class Libcap < Formula
  desc "User-space interfaces to POSIX 1003.1e capabilities"
  homepage "https://sites.google.com/site/fullycapable/"
  url "https://mirrors.edge.kernel.org/pub/linux/libs/security/linux-privs/libcap2/libcap-2.78.tar.xz"
  sha256 "0d621e562fd932ccf67b9660fb018e468a683d7b827541df27813228c996bb11"
  license all_of: ["BSD-3-Clause", "GPL-2.0-or-later"]
  compatibility_version 1

  livecheck do
    url "https://mirrors.edge.kernel.org/pub/linux/libs/security/linux-privs/libcap2/"
    regex(/href=.*?libcap[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "7be1098bf7232709b53af2f463ed6e4781b97bcc781fb9b863928704f2ec826a"
  end

  depends_on :linux

  deny_network_access!

  def install
    # The source build compiles the Go cap/psx packages and example programs.
    # AOSC's gcc-go is not the required Go toolchain; use the installed native
    # toolchain at build time only. All modules are vendored by libcap.
    ENV.prepend_path "PATH", "/home/houge/infra/tools/go/bin"
    ENV["GOTOOLCHAIN"] = "local"
    ENV["GOPROXY"] = "off"
    system "make", "install", "prefix=#{prefix}", "lib=lib", "RAISE_SETFCAP=no"
  end

  test do
    assert_match "usage", shell_output("#{sbin}/getcap 2>&1", 1)
  end
end
