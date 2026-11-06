class Ksh93 < Formula
  desc "KornShell, ksh93"
  homepage "https://github.com/ksh93/ksh"
  url "https://github.com/ksh93/ksh/archive/refs/tags/v1.0.10.tar.gz"
  sha256 "9f4c7a9531cec6941d6a9fd7fb70a4aeda24ea32800f578fd4099083f98b4e8a"
  license "EPL-2.0"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "ea1fd58d25c0089f5e434d3d7591ce0bc0f9e049180d98b793c414e21740a018"
  end

  head "https://github.com/ksh93/ksh.git", branch: "dev"



  def install
    ENV.append "LDFLAGS", "-Wl,-rpath,#{lib}"
    ENV.append "LDFLAGS", "-Wl,-headerpad_max_install_names" if OS.mac?

    system "bin/package", "verbose", "make"
    system "bin/package", "verbose", "install", prefix
    %w[ksh93 rksh rksh93].each do |alt|
      bin.install_symlink "ksh" => alt
      man1.install_symlink "ksh.1" => "#{alt}.1"
    end
    doc.install "ANNOUNCE"
    doc.install %w[COMPATIBILITY README RELEASE TYPES].map { |f| "src/cmd/ksh93/#{f}" }
  end

  test do
    system "#{bin}/ksh93 -c 'A=$(((1./3)+(2./3)));test $A -eq 1'"
  end
end
