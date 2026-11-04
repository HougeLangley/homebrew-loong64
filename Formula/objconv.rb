class Objconv < Formula
  desc "Object file converter"
  homepage "https://www.agner.org/optimize/#objconv"
  url "https://www.agner.org/optimize/objconv.zip"
  version "2026-05-14"
  sha256 "0f604f93f97f689afd7615c86176eb15bc95001eadf8317f17ebd099c50c59e1"
  license "GPL-3.0-or-later"

  livecheck do
    url :homepage
    regex(/objconv\.zip,.*?last\s+modified:\s+(\d{4}-(?:[a-z]+|\d{2})-\d{2})/im)
    strategy :page_match do |page, regex|
      date = page[regex, 1]
      next if date.blank?

      Date.parse(date).strftime("%Y-%m-%d")
    end
  end


  uses_from_macos "unzip" => :build

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "84ed5ae0ccc98fe1bb91b04417a8496d0bb0df3ed8f281dc6f2d971e4cd3cf8c"
  end

  def install
    system "unzip", "source"
    system "./build.sh"

    bin.install "objconv"
    doc.install "objconv-instructions.pdf"
  end

  test do
    (testpath/"foo.c").write "int foo() { return 0; }\n"

    system "make", "foo.o"
    assert_match "foo", shell_output("nm foo.o")

    # Rename `foo` to `main`. At least one of `make` or `./bar` will fail if this did not succeed.
    sym_prefix = OS.mac? ? "_" : ""
    system bin/"objconv", "-nr:#{sym_prefix}foo:#{sym_prefix}main", "foo.o", "bar.o"
    system "make", "bar"
    refute_match "foo", shell_output("nm bar")
    system "./bar"
  end
end
