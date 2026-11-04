class Json2tsv < Formula
  desc "JSON to TSV converter"
  homepage "https://codemadness.org/json2tsv.html"
  url "https://codemadness.org/releases/json2tsv/json2tsv-1.2.tar.gz"
  sha256 "113e5a7aeb295e7f8135f231cad900091f99aebd6c98316f761d377e9b50fd84"
  license "ISC"

  livecheck do
    url "https://codemadness.org/releases/json2tsv/"
    regex(/href=.*?json2tsv[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  conflicts_with "jaq", because: "both install `jaq` binaries"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "be9fa8b90bd7bd6786b0997cddd6da667b49805a7f7bec0689c97a1e592b9659"
  end

  def install
    system "make", "install", "PREFIX=#{prefix}", "MANPREFIX=#{man}"
  end

  test do
    input = "{\"foo\": \"bar\", \"baz\": [12, 34]}"
    expected_output = <<~EOS
      \to\t
      .foo\ts\tbar
      .baz\ta\t
      .baz[]\tn\t12
      .baz[]\tn\t34
    EOS

    assert_equal expected_output, pipe_output(bin/"json2tsv", input)
  end
end
