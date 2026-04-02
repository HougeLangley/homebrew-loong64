class Gh < Formula
  desc "GitHub command-line tool"
  homepage "https://github.com/cli/cli"
  url "https://github.com/cli/cli/archive/refs/tags/v2.67.0.tar.gz"
  sha256 "8f685e48bd262d266a8a210f36f653a4000126d085e956e2f9299cb03c20a766"
  license "MIT"
  head "https://github.com/cli/cli.git", branch: "trunk"

  depends_on "go" => :build

  def install
    with_env(
      "GH_VERSION" => version.to_s,
      "GO_LDFLAGS" => "-s -w -X main.updaterEnabled=cli/cli",
    ) do
      system "make", "bin/gh", "manpages"
    end
    bin.install "bin/gh"
    man1.install Dir["share/man/man1/gh*.1"]
    generate_completions_from_executable(bin/"gh", "completion", "-s")
  end

  test do
    system bin/"gh", "--version"
  end
end
