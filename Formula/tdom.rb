class Tdom < Formula
  desc "XML/DOM/XPath/XSLT/HTML/JSON implementation for Tcl"
  homepage "https://tdom.org/"
  url "https://tdom.org/downloads/tdom-0.9.6-src.tgz"
  sha256 "6d24734aef46d1dc16f3476685414794d6a4e65f48079e1029374477104e8319"
  license "MPL-2.0"

  livecheck do
    url :homepage
    regex(/Version\s+(\d+(?:\.\d+)+)/i)
  end




  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "5cc5245e689fcb255c011013b97b34cd08888e9b62e650effdbde109febc1623"
  end

  depends_on "tcl-tk"

  def install
    # Build against the SYSTEM Tcl 8.6: the prefix ships tcl-tk 9.1, and a
    # mixed build (9.1-named library carrying an 8.6 stub table) fails to
    # load under both interpreters ("this extension is compiled for Tcl 8.6").
    # AOSC always provides tclsh8.6, keeping keg and test consistent.
    system "./configure", "--disable-silent-rules", "--with-tcl=/usr/lib",
                          "--with-tclinclude=/usr/include", *std_configure_args
    system "make", "install"
  end

  test do
    # The prefix tclsh may be a newer Tcl than the tdom stub was compiled for
    # ("this extension is compiled for Tcl 8.6"); locate the stub's own
    # tclsh from the tcl-ttdom? No — use the system 8.6 tclsh explicitly.
    test_tdom = <<~TCL
      if {[catch {
        package require tdom

        set xml {<?xml version="1.0"?>
          <root>
            <child>12345</child>
          </root>}

        set doc [dom parse $xml]
        set node [$doc selectNodes root/child/text()]
        if {[$node data] == "12345"} {
          puts "OK"
        }
      } resultVar]} {
        puts $resultVar
      }
    TCL

    tclsh = File.exist?("/usr/bin/tclsh8.6") ? "/usr/bin/tclsh8.6" : "#{ENV["HOMEBREW_PREFIX"]}/bin/tclsh"
    lib_dir = Dir["#{lib}/tdom*"].first
    ENV["TCLLIBPATH"] = lib_dir if lib_dir
    assert_equal "OK", pipe_output(tclsh, test_tdom).chomp
  end
end
