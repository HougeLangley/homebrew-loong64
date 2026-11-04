class Nanomsg < Formula
  desc "Socket library in C"
  homepage "https://nanomsg.org/"
  url "https://github.com/nanomsg/nanomsg/archive/refs/tags/1.3.0.tar.gz"
  sha256 "acf65c0ef312f431aa3c4cb114326781c999ec0c977067f3a1f0c81b5ec8710f"
  license "MIT"
  compatibility_version 1
  head "https://github.com/nanomsg/nanomsg.git", branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "4aad9e0294cae7ae542284473f52de288a328cbcfa1ea1106a3dadf3819d57e1"
  end

  depends_on "cmake" => :build

  allow_network_access! :test

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    bind = "tcp://127.0.0.1:#{free_port}"
    spawn bin/"nanocat", "--rep", "--bind", bind, "--format", "ascii", "--data", "home"
    sleep 2
    output = shell_output("#{bin}/nanocat --req --connect #{bind} --format ascii --data brew")
    assert_match "home", output
  end
end
