class Fwup < Formula
  desc "Configurable embedded Linux firmware update creator and runner"
  homepage "https://github.com/fwup-home/fwup"
  url "https://github.com/fwup-home/fwup/releases/download/v1.17.1/fwup-1.17.1.tar.gz"
  sha256 "7672c6568b7538ed81b8557c91bf3a198599dc9eb6f69ea4441cee8b1e87c098"
  license "Apache-2.0"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "dc2825cb8b5347aeaf3afd453ac490b08879070c800eb5a40d832d9432441a6f"
  end


  depends_on "pkgconf" => :build
  depends_on "confuse"
  depends_on "libarchive"

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", *std_configure_args
    system "make", "install"
  end

  test do
    system bin/"fwup", "-g"
    assert_path_exists testpath/"fwup-key.priv", "Failed to create fwup-key.priv!"
    assert_path_exists testpath/"fwup-key.pub", "Failed to create fwup-key.pub!"
  end
end
