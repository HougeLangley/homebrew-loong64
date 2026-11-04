class Acpica < Formula
  desc "OS-independent implementation of the ACPI specification"
  homepage "https://github.com/acpica/acpica"
  url "https://github.com/acpica/acpica/releases/download/20260408/acpica-unix2-20260408.tar.gz"
  sha256 "5fcef9f0d00ffaffaaa82aa49c5ea9687986e8a7bd60929e298cc99a6741ae24"
  license any_of: ["Intel-ACPI", "GPL-2.0-only", "BSD-3-Clause"]
  head "https://github.com/acpica/acpica.git", branch: "master"

  livecheck do
    url "https://www.intel.com/content/www/us/en/download/776303/acpi-component-architecture-downloads-unix-format-source-code-and-build-environment-with-an-intel-license.html",
        user_agent: :browser
    regex(/href=.*?acpica-unix[._-]v?(\d+(?:\.\d+)*)\.t/i)
  end


  uses_from_macos "bison" => :build
  uses_from_macos "flex" => :build
  uses_from_macos "m4" => :build

  deny_network_access!

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "8f85a6d8863c3b1d7527425efae0529060bc0150f369bac19647fac2417f279f"
  end

  def install
    # ACPI_PACKED_POINTERS_NOT_SUPPORTED:
    # https://github.com/acpica/acpica/issues/781#issuecomment-1718084901
    system "make", "PREFIX=#{prefix}", "OPT_CFLAGS=\"-DACPI_PACKED_POINTERS_NOT_SUPPORTED\""
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    system bin/"acpihelp", "-u"
  end
end
