class Try < Formula
  desc "Quickly manage and navigate project directories for experiments"
  homepage "https://github.com/tobi/try"
  url "https://github.com/tobi/try/archive/refs/tags/v1.10.1.tar.gz"
  sha256 "4520a71a2485e04b09a93514d4818ad24800ea4738b8dceba24e941cbe2fc879"
  license "MIT"
  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "7985e341e145fcbb6997d17a9659d83f4d8f88f8fba53a66bac721c759ed411e"
  end

  head "https://github.com/tobi/try.git", branch: "main"



  depends_on "ruby"

  deny_network_access!

  def install
    ENV["GEM_HOME"] = libexec

    gem_name = "try-cli"
    system "bundle", "install", "--local"
    system "gem", "build", "#{gem_name}.gemspec"
    system "gem", "install", "--ignore-dependencies", "#{gem_name}-#{version}.gem"

    bin.install libexec/"bin/#{name}"
    bin.env_script_all_files(libexec/"bin", GEM_HOME: ENV["GEM_HOME"])
  end

  test do
    try_dir = "#{Dir.pwd}/src/tries/#{Date.today.iso8601}-tobi-try"
    expected_mkdir_command = "mkdir -p '#{try_dir}'"
    expected_clone_command = "git clone 'https://github.com/tobi/try.git' '#{try_dir}'"
    expected_cd_command = "cd '#{try_dir}'"
    output = shell_output("#{bin}/try exec clone https://github.com/tobi/try.git").chomp
    assert_match expected_mkdir_command, output
    assert_match expected_clone_command, output
    assert_match expected_cd_command, output
  end
end
