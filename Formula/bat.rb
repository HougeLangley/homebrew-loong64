class Bat < Formula
  desc "Clone of cat(1) with syntax highlighting and Git integration"
  homepage "https://github.com/sharkdp/bat"
  url "https://github.com/sharkdp/bat/archive/refs/tags/v0.25.0.tar.gz"
  sha256 "7f6c55a0e00820a1b34653cb23d5eb8200742af7ba51a0c35bacae30ae427402"
  license "Apache-2.0"

  bottle do
    root_url "https://homebrewloongarch64.site/bottles"
    sha256 cellar: :any, loongarch64_linux: "5e16fc0a5eadc5ee02daa67d2aaa4ff3a838955085b4062208537f547a15ce50"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "build", "--release"
    
    bin.install "target/release/bat"
    
    assets_dir = Dir["target/release/build/bat-*/out/assets"].first
    if assets_dir
      man1.install Dir["#{assets_dir}/manual/bat.*.1"]
      bash_completion.install "#{assets_dir}/completions/bat.bash" => "bat"
      fish_completion.install "#{assets_dir}/completions/bat.fish"
      zsh_completion.install "#{assets_dir}/completions/bat.zsh" => "_bat"
    end
  end

  test do
    system "#{bin}/bat", "--version"
  end
end
