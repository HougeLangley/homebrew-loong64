class Dory < Formula
  desc "Development proxy for docker"
  homepage "https://github.com/freedomben/dory"
  url "https://github.com/FreedomBen/dory/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "8c385d898aed2de82f7d0ab5c776561ffe801dd4b222a07e25e5837953355b81"
  license "MIT"


  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "0f75850c636da1c32f1883f5b6dadad5b18075133bc60e138bbc95a0b0a8708a"
  end

  depends_on "ruby"

  deny_network_access!

  def fetch
    ENV["BUNDLE_PATH"] = ".bundle"

    system "bundle", "cache", "--no-install"
  end

  def install
    ENV["GEM_HOME"] = libexec

    system "bundle", "install", "--local"
    system "gem", "build", "#{name}.gemspec"
    system "gem", "install", "--ignore-dependencies", "#{name}-#{version}.gem"

    bin.install libexec/"bin/#{name}"
    bin.env_script_all_files(libexec/"bin", GEM_HOME: ENV["GEM_HOME"])
  end

  test do
    shell_output(bin/"dory")

    system bin/"dory", "config-file"
    assert_path_exists testpath/".dory.yml", "Dory could not generate config file"

    version = shell_output("#{bin}/dory version")
    assert_match version.to_s, version, "Unexpected output of version"
  end
end
