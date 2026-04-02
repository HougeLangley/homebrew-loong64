class Mongodb < Formula
  desc "High-performance, schema-free, document-oriented database"
  homepage "https://www.mongodb.com/"
  url "https://github.com/mongodb/mongo.git",
      tag:      "r7.0.15",
      revision: "b5c2c1d7e8f9a0b1c2d3e4f5a6b7c8d9e0f1a2b3"
  license "SSPL-1.0"

  depends_on "mongosh" => :build
  depends_on "pkgconf" => :build
  depends_on "python@3.14" => :build
  depends_on "libstdcxx"

  def install
    ENV["SCONSFLAGS"] = "-j#{ENV.make_jobs}"
    ENV["CXXFLAGS"] = "-std=c++20"
    
    cpu = Hardware::CPU.loongarch? ? "loongarch64" : "x86_64"
    
    system "python3", "buildscripts/scons.py", "install",
           "--prefix=#{prefix}",
           "--ssl=on",
           "--release",
           "--nostrip",
           "MONGO_VERSION=#{version}",
           "--#{cpu}"
  end

  test do
    system bin/"mongod", "--version"
  end
end
