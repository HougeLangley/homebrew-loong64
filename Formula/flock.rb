class Flock < Formula
  desc "Lock file during command"
  homepage "https://github.com/discoteq/flock"
  url "https://github.com/discoteq/flock/releases/download/v0.4.0/flock-0.4.0.tar.xz"
  sha256 "01bbd497d168e9b7306f06794c57602da0f61ebd463a3210d63c1d8a0513c5cc"
  license "ISC"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "c73b32a290453a71ccf75802011cf83ace26b0ac2967eb7ceddad927acdd5428"
  end


  on_linux do
    conflicts_with "util-linux", because: "both install `flock` binaries"
  end

  deny_network_access!

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-silent-rules", *std_configure_args
    system "make", "install"
  end

  test do
    pid = spawn bin/"flock", "tmpfile", "sleep", "5"
    sleep 1
    assert_empty shell_output("#{bin}/flock --nonblock tmpfile true", 1)
  ensure
    Process.wait pid
  end
end
