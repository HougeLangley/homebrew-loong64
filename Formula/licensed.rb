class Licensed < Formula
  desc "Cache and verify the licenses of dependencies"
  homepage "https://github.com/licensee/licensed"
  url "https://github.com/licensee/licensed.git",
      tag:      "v5.1.0",
      revision: "5cefad36349e5798ab0e4e33551907ff999ccbaa"
  license "MIT"


  bottle do
    rebuild 3
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "0358b689af1e948d2bcb4e0f391e066eff27eadb7524f8f19eb9c88a3d58fcfb"
  end

  depends_on "cmake" => :build
  depends_on "pkgconf" => :build
  depends_on "libgit2"
  depends_on "ruby"

  uses_from_macos "libxml2"
  uses_from_macos "libxslt"

  on_linux do
    depends_on "zlib-ng-compat"
  end

  deny_network_access!

  def fetch
    ENV["BUNDLE_PATH"] = ".bundle"

    # Locked rugged 1.9.0 cannot detect libgit2 1.9; remove once upstream updates Gemfile.lock
    inreplace "Gemfile.lock", "rugged (1.9.0)", "rugged (1.9.6)"

    system "bundle", "cache", "--no-install"
  end

  def install
    ENV["GEM_HOME"] = libexec

    system "bundle", "config", "set", "build.nokogiri", "--use-system-libraries"
    system "bundle", "config", "set", "build.rugged", "--use-system-libraries"
    system "bundle", "install", "--local"
    system "gem", "build", "#{name}.gemspec"
    system "gem", "install", "--ignore-dependencies", "#{name}-#{version}.gem"

    bin.install libexec/"bin/#{name}"
    bin.env_script_all_files(libexec/"bin", GEM_HOME: ENV["GEM_HOME"])
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/licensed version").strip

    (testpath/"Gemfile").write <<~RUBY
      source 'https://rubygems.org'
      gem 'licensed', '#{version}'
    RUBY

    (testpath/".licensed.yml").write <<~YAML
      name: 'test'
      allowed:
        - mit
    YAML

    assert_match "Caching dependency records for test", shell_output("#{bin}/licensed cache")
  end
end
