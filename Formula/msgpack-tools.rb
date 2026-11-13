class MsgpackTools < Formula
  desc "Command-line tools for converting between MessagePack and JSON"
  homepage "https://github.com/ludocode/msgpack-tools"
  url "https://github.com/ludocode/msgpack-tools/releases/download/v0.6/msgpack-tools-0.6.tar.gz"
  sha256 "98c8b789dced626b5b48261b047e2124d256e5b5d4fbbabdafe533c0bd712834"
  license "MIT"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "9c5401ea13cfb4594d0e18837c4d211ed3e56d98f568e44650043783432f7c6d"
  end

  depends_on "cmake" => :build

  conflicts_with "remarshal", because: "both install 'json2msgpack' binary"

  deny_network_access!

  def install
    # Workaround for CMake 4 compatibility
    args = %w[-DCMAKE_POLICY_VERSION_MINIMUM=3.5]
    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    # AOSC rapidjson 0001: assigning the const members is not valid C++ and
    # GCC 15+ diagnoses it while instantiating the class template.
    rapidjson_header = Dir["build/contrib/rapidjson-*/include/rapidjson/document.h"].first
    raise "bundled rapidjson document.h not found" unless rapidjson_header
    inreplace rapidjson_header, /^\s*GenericStringRef& operator=.*\n/, ""
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    json_data = <<~JSON
      {"hello":"world"}
    JSON

    msgpack_data = pipe_output("#{bin}/json2msgpack", json_data)
    output = pipe_output("#{bin}/msgpack2json", msgpack_data)
    assert_equal json_data.strip, output.strip
  end
end
