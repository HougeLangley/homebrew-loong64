class Mruby < Formula
  desc "Lightweight implementation of the Ruby language"
  homepage "https://mruby.org/"
  url "https://github.com/mruby/mruby/archive/refs/tags/4.0.0.tar.gz"
  sha256 "e2ea271dbed14e9f2b33df773ae447b747dbc242ce2675022c0a57efea85a7b4"
  license "MIT"
  head "https://github.com/mruby/mruby.git", branch: "master"


  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "75e66e3224e40c7e6167fb317723d2492573df26f03e55cf30975a45920737da"
  end

  depends_on "bison" => :build
  uses_from_macos "ruby" => :build

  on_linux do
    depends_on "readline"
  end

  def install
    cp "build_config/default.rb", buildpath/"homebrew.rb"
    inreplace buildpath/"homebrew.rb",
      "conf.gembox 'default'",
      "conf.gembox 'full-core'"
    ENV["MRUBY_CONFIG"] = buildpath/"homebrew.rb"

    system "make"

    cd "build/host/" do
      lib.install Dir["lib/*.a"]
      prefix.install %w[bin include mrbgems mrblib]
    end
  end

  test do
    system bin/"mruby", "-e", "true"
  end
end
