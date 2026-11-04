class Lci < Formula
  desc "Interpreter for the lambda calculus"
  homepage "https://www.chatzi.org/lci/"
  url "https://github.com/chatziko/lci/releases/download/v1.1/lci-v1.1.tar.gz"
  sha256 "51725e33a7066100757b7da84b2290a651a5f47b985eb3e3647acd871964cd58"
  license "GPL-2.0-or-later"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "9e1fa705057e59c6b60c5282c33a8922d70b0e462304110b6bb309e488b7acb2"
  end

  depends_on "cmake" => :build

  conflicts_with "lolcode", because: "both install `lci` binaries"

  deny_network_access!

  def install
    # Workaround for CMake 4 compatibility
    args = %w[-DCMAKE_POLICY_VERSION_MINIMUM=3.5]
    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    assert_match "[I, 2]", pipe_output(bin/"lci", "Append [1] [2]\n")
  end
end
