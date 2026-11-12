class Fftw < Formula
  desc "C routines to compute the Discrete Fourier Transform (system stub)"
  homepage "https://fftw.org"
  url "file:///home/houge/infra/srv/stubs/fftw-3.3.11.tar.gz"
  sha256 "7f3f4717439b4c9958b1eedd104a9cce71532ae93ac73663b38d54552d3444b0"
  version "3.3.11"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "b2c9bde90534af31abd668b834aca92a28bfa19dd001c15059bc48b7dfaf2567"
  end

  def install
    bin.mkpath; lib.mkpath; include.mkpath
    # Bridge system fftw headers and all precision libraries
    (include/"fftw3.h").make_symlink "/usr/include/fftw3.h" if File.exist?("/usr/include/fftw3.h")
    Dir["/usr/lib/libfftw3*.so*"].each { |l| (lib/File.basename(l)).make_symlink l }
    # Bridge pkg-config for all precision variants
    (lib/"pkgconfig").mkpath
    Dir["/usr/lib/pkgconfig/fftw3*.pc"].each do |pc|
      t = File.read(pc).gsub("includedir=/usr/include", "includedir=#{include}").gsub("libdir=/usr/lib", "libdir=#{lib}")
      (lib/"pkgconfig/#{File.basename(pc)}").write(t)
    end
    (prefix/"system_stub").write "provided by AOSC OS\n"
  end

  test do
    assert_predicate prefix/"system_stub", :exist?
    assert_predicate lib/"libfftw3.so", :exist? if File.exist?("/usr/lib/libfftw3.so")
    assert_predicate include/"fftw3.h", :exist? if File.exist?("/usr/include/fftw3.h")
  end
end
