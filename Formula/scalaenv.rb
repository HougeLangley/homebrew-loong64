class Scalaenv < Formula
  desc "Command-line tool to manage Scala environments"
  homepage "https://github.com/scalaenv/scalaenv"
  url "https://github.com/scalaenv/scalaenv/archive/refs/tags/version/0.1.14.tar.gz"
  sha256 "82adc5edd81f1914fae321deea36123bc4d3a255e47afa857cbd8b093903530c"
  license "MIT"
  head "https://github.com/scalaenv/scalaenv.git", branch: "master"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "82a533924f0c31df523daacc3b84f46103c805652c8db246e9b012b1b8c46afe"
  end

  def install
    inreplace "libexec/scalaenv", "/usr/local", HOMEBREW_PREFIX
    prefix.install "bin", "completions", "libexec"
    prefix.install "plugins" => "default-plugins"

    %w[scalaenv-install scalaenv-uninstall scala-build].each do |cmd|
      bin.install_symlink "#{prefix}/default-plugins/scala-install/bin/#{cmd}"
    end

    prefix.install_symlink (var/"lib/scalaenv/plugins").mkpath
    prefix.install_symlink (var/"lib/scalaenv/versions").mkpath
  end

  post_install_steps do
    symlink "{{prefix}}/default-plugins/scala-install", "{{var}}/lib/scalaenv/plugins/scala-install", overwrite: true
  end

  test do
    shell_output("eval \"$(#{bin}/scalaenv init -)\" && scalaenv versions")
  end
end
