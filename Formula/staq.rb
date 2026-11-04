class Staq < Formula
  desc "Full-stack quantum processing toolkit"
  homepage "https://iopscience.iop.org/article/10.1088/2058-9565/ab9359/pdf"
  url "https://github.com/softwareQinc/staq/archive/refs/tags/v3.5.tar.gz"
  sha256 "838402b6ca541200740cc3ab989b3026f3b001ebf3e1ce7d89ae7f09a0e33195"
  license "MIT"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "a18e8ec5f56ae69ae559887dcfdc1851c990bb87ec8b38717cca5981b8eb21cb"
  end

  depends_on "cmake" => :build
  depends_on "gmp"

  # Backport fix to error: no member named 'row' in 'col_vec2_t<T>'
  patch do
    url "https://github.com/softwareQinc/staq/commit/4ac5dcd13ae46dd629ee938602452a5c8ec0b7c0.patch?full_index=1"
    sha256 "c71447c1fd065e8818894965219e0fad652c3a8649be645296d4bc9ca5a9d656"
    type :backport
    resolves "https://github.com/softwareQinc/staq/issues/85"
  end

  # Backport newer bundled fmt
  patch do
    url "https://github.com/softwareQinc/staq/commit/6847ebed2d167a0f1aa476cfb1d2b62b54fde6f9.patch?full_index=1"
    sha256 "acdcdd7afd9650425f1659b0b3b0e601c27e368d3722385416dcc5ee145528f1"
    type :backport
    resolves "https://github.com/softwareQinc/staq/pull/86"
  end

  def install
    system "cmake", "-S", ".", "-B", "build",
                    "-DINSTALL_SOURCES=ON",
                    "-DFETCHCONTENT_SOURCE_DIR_GOOGLETEST=/dev/null", # skip unused FetchContent
                    "-DPython3_EXECUTABLE=/dev/null", # skip macOS /usr/bin/python3
                    *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"input.qasm").write <<~QASM
      OPENQASM 2.0;
      include "qelib1.inc";

      qreg q[1];
      creg c[1];
      h q[0];
      h q[0];
      measure q->c;
    QASM
    assert_equal <<~QASM, shell_output("#{bin}/staq -O3 ./input.qasm").chomp
      OPENQASM 2.0;
      include "qelib1.inc";

      qreg q[1];
      creg c[1];
      measure q[0] -> c[0];
    QASM
  end
end
