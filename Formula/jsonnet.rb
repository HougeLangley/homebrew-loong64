class Jsonnet < Formula
  desc "Domain specific configuration language for defining JSON data"
  homepage "https://jsonnet.org/"
  url "https://github.com/google/jsonnet/archive/refs/tags/v0.22.0.tar.gz"
  sha256 "5914b9904d97efa662d919519cef1a14e4132bfddddaeed8b061b4a8af628f8d"
  license "Apache-2.0"
  head "https://github.com/google/jsonnet.git", branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end


  conflicts_with "go-jsonnet", because: "both install binaries with the same name"

  deny_network_access!

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "effd015da638d045f1d420f14024c7a34f83f49330f2ac6cfa9fc956376677ee"
  end

  def install
    system "make"
    bin.install "jsonnet"
    bin.install "jsonnetfmt"
  end

  test do
    (testpath/"example.jsonnet").write <<~JSONNET
      {
        person1: {
          name: "Alice",
          welcome: "Hello " + self.name + "!",
        },
        person2: self.person1 { name: "Bob" },
      }
    JSONNET

    expected_output = {
      "person1" => {
        "name"    => "Alice",
        "welcome" => "Hello Alice!",
      },
      "person2" => {
        "name"    => "Bob",
        "welcome" => "Hello Bob!",
      },
    }

    output = shell_output("#{bin}/jsonnet #{testpath}/example.jsonnet")
    assert_equal expected_output, JSON.parse(output)
  end
end
