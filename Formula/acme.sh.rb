class AcmeSh < Formula
  desc "ACME client"
  homepage "https://github.com/acmesh-official/acme.sh"
  url "https://github.com/acmesh-official/acme.sh/archive/refs/tags/3.1.6.tar.gz"
  sha256 "0d3f9000ac44a6331314742a88c475f79134e24fc991997883652adc59efc486"
  license "GPL-3.0-only"


  deny_network_access!

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "606317189ef83a385187c92c9f94fcce6a14f885b4a5aea764c5f901f67739fe"
  end

  def install
    libexec.install [
      "acme.sh",
      "deploy",
      "dnsapi",
      "notify",
    ]

    bin.install_symlink libexec/"acme.sh"
    bash_completion.install "acme.sh.completion" => "acme.sh"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/acme.sh --version")

    expected = /Main_Domain\s*KeyLength\s*SAN_Domains\s*Profile\s*CA\s*Created\s*Renew/i
    assert_match expected, shell_output("#{bin}/acme.sh --list")
  end
end
