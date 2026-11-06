class Msktutil < Formula
  desc "Active Directory keytab management"
  homepage "https://github.com/msktutil/msktutil"
  url "https://github.com/msktutil/msktutil/releases/download/1.2.2/msktutil-1.2.2.tar.bz2"
  sha256 "51314bb222c20e963da61724c752e418261a7bfc2408e7b7d619e82a425f6541"
  license "GPL-2.0-or-later"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "5286415aa08e65d34b35e4d97e182c843728ea561c3db9e2cc131ab7a60c71e1"
  end


  # macos builtin krb5 has `krb5-config reports unknown vendor Apple MITKerberosShim` error
  depends_on "krb5"

  uses_from_macos "cyrus-sasl"
  uses_from_macos "openldap"

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-silent-rules",
                          "--mandir=#{man}",
                          *std_configure_args
    system "make", "install"
  end

  test do
    assert_match version.to_s, shell_output("#{sbin}/msktutil --version")
  end
end
