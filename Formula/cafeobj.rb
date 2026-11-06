class Cafeobj < Formula
  desc "New generation algebraic specification and programming language"
  homepage "https://cafeobj.org/"
  url "https://github.com/CafeOBJ/cafeobj/archive/refs/tags/v1.6.2.tar.gz"
  sha256 "b5ea4267b7b4ff3d85a970b6330f706b81ef872968230608005c9b3d168b0065"
  license all_of: [
    "BSD-2-Clause",
    :public_domain, # comlib/let-over-lambda.lisp
    "MIT", # asdf.lisp
  ]
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "8e94398d79e31d3f879c9faf1cd2346d1c383e4dc4eab30c51b09566d53ccf53"
  end

  head "https://github.com/CafeOBJ/cafeobj.git", branch: "master"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end


  depends_on "clisp"

  deny_network_access!

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    # Exclude unrecognized options
    args = std_configure_args.reject { |s| s["--disable-debug"] || s["--disable-dependency-tracking"] }

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--with-lisp=clisp", "--with-lispdir=#{elisp}", *args
    system "make", "install"
  end

  test do
    system bin/"cafeobj", "-batch"
  end
end
