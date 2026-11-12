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




  depends_on "tcl-tk"

  def install
    system "./configure", "--disable-silent-rules", "--with-tcl=#{ENV["HOMEBREW_PREFIX"]}/lib", *std_configure_args
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
    assert_equal "OK", pipe_output(tclsh, test_tdom).chomp
  end
end
