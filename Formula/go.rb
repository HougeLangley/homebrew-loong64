class Go < Formula
  desc "Open source programming language to build simple/reliable/efficient software"
  homepage "https://go.dev/"
  url "https://go.dev/dl/go1.24.2.src.tar.gz"
  sha256 "4a5798640f1f1dbdcceebd0ac5b8fed9771230445e226363d0da039cf6cd24e4"
  license "BSD-3-Clause"
  head "https://go.googlesource.com/go.git", branch: "master"

  livecheck do
    url "https://go.dev/dl/?mode=json"
    regex(/^go[._-]?v?(\d+(?:\.\d+)+)\.src\.tar\.gz$/i)
  end

  depends_on "go" => :build

  def install
    ENV["GOROOT_BOOTSTRAP"] = buildpath/"go"

    cd "src" do
      ENV["GOARCH"] = "loong64"
      ENV["GOOS"] = "linux"
      system "./make.bash"
    end

    bin.install "bin/go"
    bin.install "bin/gofmt"
    
    libexec.install Dir["*"]
    bin.install_symlink Dir[libexec/"bin/go*"]

    rm_rf libexec/"misc/android"
  end

  test do
    (testpath/"hello.go").write <<~EOS
      package main
      import "fmt"
      func main() {
        fmt.Println("Hello World")
      }
    EOS
    system bin/"go", "run", "hello.go"
  end
end
