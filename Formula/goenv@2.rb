class GoenvAT2 < Formula
  desc "Go version management"
  homepage "https://github.com/go-nv/goenv"
  url "https://github.com/go-nv/goenv/archive/refs/tags/2.2.48.tar.gz"
  sha256 "7cc888037ef367c20128aff107eb90d84ee56a61cc8ef34beac61ec641c3ea22"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(2\.\d+\.\d+)$/i)
  end


  keg_only :versioned_formula

  # Goenv version 3.0.0 was released 2026-05-04
  deprecate! date: "2026-05-04", because: "superseded by v3.x; disables 2028-12-31", replacement_formula: "goenv"

  # End-of-support on 2028-12-31: https://github.com/go-nv/goenv/pull/525
  disable! date: "2028-12-31", because: :unmaintained

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "03bb48e15744950be150edee6f833d7fa7e8e2ae1d1b7d743fa42f489b86792b"
  end

  def install
    inreplace_files = [
      "libexec/goenv",
      "plugins/go-build/install.sh",
      "test/goenv.bats",
      "test/test_helper.bash",
      "plugins/go-build/test/test_helper.bash",
    ]
    inreplace inreplace_files, "/usr/local", HOMEBREW_PREFIX

    prefix.install Dir["*"]
    %w[goenv-install goenv-uninstall go-build].each do |cmd|
      bin.install_symlink "#{prefix}/plugins/go-build/bin/#{cmd}"
    end
  end

  test do
    # Upstream's test assumes no system Go; our build hosts have Go in PATH,
    # making `goenv versions` exit 0. Use a hermetic GOENV_ROOT like the
    # project's own bats tests instead of depending on the host environment.
    root = testpath/"goenv-root"
    (root/"versions/1.21.0").mkpath
    ENV["GOENV_ROOT"] = root
    assert_match "1.21.0", shell_output("#{bin}/goenv versions 2>&1")
  end
end
