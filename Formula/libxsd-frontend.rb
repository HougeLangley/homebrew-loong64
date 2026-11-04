class LibxsdFrontend < Formula
  desc "Compiler frontend for the W3C XML Schema definition language"
  homepage "https://www.codesynthesis.com/projects/libxsd-frontend/"
  url "https://www.codesynthesis.com/download/xsd/4.2/libxsd-frontend-2.1.0.tar.gz"
  sha256 "98321b9c2307d7c4e1eba49da6a522ffa81bdf61f7e3605e469aa85bfcab90b1"
  license "GPL-2.0-only" # with Xerces-C++ linking exception (non-SPDX)

  # Versions of libxsd-frontend beyond 2.0.0 (from 2014) are provided as XSD
  # dependencies, so we have to check within XSD releases.
  livecheck do
    url "https://www.codesynthesis.com/products/xsd/download.xhtml"
    regex(/href=.*?libxsd-frontend[._-]v?(\d+(?:\.\d+)+)\.t/i)
    strategy :page_match do |page, regex|
      # Identify the "XSD dependencies" URL on the XSD download page
      xsd_url = page[%r{href=["']?(["' >]*?/download/xsd/v?\d+(?:\.\d+)+)/?["' >]}i, 1]
      next unless xsd_url

      # Fetch the directory listing page for the XSD version
      xsd_page = Homebrew::Livecheck::Strategy.page_content(
        URI.join(@url, xsd_url).to_s,
      )[:content]
      next unless xsd_page

      xsd_page.scan(regex).map(&:first)
    end
  end


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "88a24dbd1451d4aa9bf8d850c7966da8cd1c5e922748b923d97a8a085a4482be"
  end

  depends_on "build2" => :build
  depends_on "libcutl"
  depends_on "xerces-c"

  def install
    system "b", "configure", "config.cc.loptions=-L#{HOMEBREW_PREFIX}/lib", "config.install.root=#{prefix}"
    system "b", "install", "--jobs=#{ENV.make_jobs}", "-V"
    pkgshare.install "tests/schema/driver.cxx" => "test.cxx"
  end

  test do
    (testpath/"test.xsd").write <<~XSD
      <?xml version="1.0" encoding="UTF-8"?>
      <xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema" elementFormDefault="qualified"
                 targetNamespace="https://brew.sh/XSDTest" xmlns="https://brew.sh/XSDTest">
        <xs:element name="MeaningOfLife" type="xs:positiveInteger"/>
      </xs:schema>
    XSD

    system ENV.cxx, "-std=c++11", pkgshare/"test.cxx", "-o", "test",
                    "-L#{lib}", "-lxsd-frontend", "-L#{formula_opt_lib("libcutl")}", "-lcutl"
    assert_equal <<~TEXT, shell_output("./test test.xsd")
      primary
      {
        namespace https://brew.sh/XSDTest
        {
          element MeaningOfLife http://www.w3.org/2001/XMLSchema#positiveInteger
        }
      }
    TEXT
  end
end
