class Sexpect < Formula
  desc "Expect for shells"
  homepage "https://github.com/clarkwang/sexpect"
  url "https://github.com/clarkwang/sexpect/archive/refs/tags/v2.4.0.tar.gz"
  sha256 "8f7a989ecf67f4ff6eb167d29a8e2e54db85143ebf3e8f904ea16ee5576a4b0d"
  license "GPL-3.0-only"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "58d04dc4cd2e42b6bb4ca4ca89760cf0cd956000601df2450a208bb8b8cb8cdf"
  end

  depends_on "cmake" => :build

  deny_network_access!

  def install
    system "cmake", "-S", ".", "-B", "build", "-DCMAKE_POLICY_VERSION_MINIMUM=3.5", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sexpect --version")

    (testpath/"test.sh").write <<~SHELL
      #!/bin/sh

      export SEXPECT_SOCKFILE="#{testpath}/s.sock"

      sexpect sp -t 10 sleep 60
      sexpect c
      sexpect c
      sexpect c
      sexpect c
      sexpect ex -t 1 -eof
      sexpect w

      [ $? -eq 129 ]
    SHELL

    system "sh", testpath/"test.sh"
  end
end
