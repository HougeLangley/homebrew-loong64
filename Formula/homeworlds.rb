class Homeworlds < Formula
  desc "C++ framework for the game of Binary Homeworlds"
  homepage "https://github.com/Quuxplusone/Homeworlds/"
  url "https://github.com/Quuxplusone/Homeworlds/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "3ffbad58943127850047ef144a572f6cc84fd1ec2d29dad1f118db75419bf600"
  license "BSD-2-Clause"
  revision 5
  version_scheme 1



  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "0ea073f383c2d76a9a97a55daa84fde39e28400b080ee0a993c9e17f06a5d348"
  end

  depends_on "wxwidgets"

  # Fix missing `#include`.
  patch do
    url "https://github.com/Quuxplusone/Homeworlds/commit/bb1a5d2395df4e097122b311c0009801107f4d3a.patch?full_index=1"
    sha256 "a133fb4bdeb4a5d2759a7257989089402e0ad84edbaed86780c26d47e58b8d55"
    type :unofficial
    resolves "https://github.com/Quuxplusone/Homeworlds/pull/6"
  end

  def install
    system "make", "homeworlds-cli", "homeworlds-wx"
    bin.install "homeworlds-cli", "homeworlds-wx"
  end

  test do
    output = shell_output(bin/"homeworlds-cli", 1)
    assert_match "Error: Incorrect command-line arguments", output
  end
end
