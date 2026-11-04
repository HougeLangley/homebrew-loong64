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
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "41e570b4ed3c0aceb4d2df27161a24a136dd0f4438390b679cab88bc168d1ce6"
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
