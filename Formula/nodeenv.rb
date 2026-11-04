class Nodeenv < Formula
  include Language::Python::Shebang

  desc "Node.js virtual environment builder"
  homepage "https://ekalinin.github.io/nodeenv/"
  url "https://github.com/ekalinin/nodeenv/archive/refs/tags/1.11.0.tar.gz"
  sha256 "5778cf62fe75dcfc32f096426b9554dadd590061c7fa47c2292fe23b8d35517e"
  license "BSD-3-Clause"


  uses_from_macos "python"

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "faa4ec2b64bf90b0e7e400845fc3ac06a091b0b53c9ab233eab31c38fd3ffe7a"
  end

  def install
    rewrite_shebang detected_python_shebang(use_python_from_path: true), "nodeenv.py"
    bin.install "nodeenv.py" => "nodeenv"
  end

  test do
    system bin/"nodeenv", "--node=16.0.0", "--prebuilt", "env-16.0.0-prebuilt"
    # Dropping into the virtualenv itself requires sourcing activate which
    # isn't easy to deal with. This ensures current Node installed & functional.
    ENV.prepend_path "PATH", testpath/"env-16.0.0-prebuilt/bin"

    (testpath/"test.js").write "console.log('hello');"
    assert_match "hello", shell_output("node test.js")
    assert_match "v16.0.0", shell_output("node -v")
  end
end
