class Elektra < Formula
  desc "Framework to access config settings in a global key database"
  homepage "https://www.libelektra.org"
  url "https://www.libelektra.org/ftp/elektra/releases/elektra-0.11.0.tar.gz"
  sha256 "4e1f7c986010555a1d30ef2d23c0636373e993bab88e5ec238cac18a469b5cc2"
  license "BSD-3-Clause"
  head "https://github.com/ElektraInitiative/libelektra.git", branch: "master"


  deprecate! date: "2025-01-10", because: :repo_archived
  disable! date: "2026-01-10", because: :repo_archived

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "5f40ba744424246282940ddbfd8d9b34ee16e783e9b3d94ecda0aba9ec258e2d"
  end

  depends_on "cmake" => :build
  depends_on "doxygen" => :build

  def install
    ENV["CMAKE_POLICY_VERSION_MINIMUM"] = "3.5"

    args = %w[
      -DBINDINGS=cpp
      -DTOOLS=kdb;
      -DPLUGINS=NODEP;-tracer
    ]

    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"

    bash_completion.install "scripts/completion/kdb-bash-completion" => "kdb"
    fish_completion.install "scripts/completion/kdb.fish"
    zsh_completion.install "scripts/completion/kdb_zsh_completion" => "_kdb"
  end

  test do
    output = shell_output("#{bin}/kdb get system:/elektra/version/infos/licence")
    assert_match "BSD", output
    shell_output("#{bin}/kdb plugin-list").split.each do |plugin|
      system bin/"kdb", "plugin-check", plugin
    end
  end
end
