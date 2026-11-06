class Ppl < Formula
  desc "Parma Polyhedra Library: numerical abstractions for analysis, verification"
  homepage "https://www.bugseng.com/ppl"
  url "https://deb.debian.org/debian/pool/main/p/ppl/ppl_1.2.orig.tar.xz"
  sha256 "691f0d5a4fb0e206f4e132fc9132c71d6e33cdda168470d40ac3cf62340e9a60"
  license "GPL-3.0-or-later"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "40a4fae58c6aaebe208ea636b8ff88e75bbc138782fb6f542047e75814814abe"
  end

  revision 1

  livecheck do
    url "https://deb.debian.org/debian/pool/main/p/ppl/"
    regex(/href=.*?ppl[._-]v?(\d+(?:\.\d+)+)\.orig\.t/i)
  end


  depends_on "gmp"

  on_linux do
    depends_on "m4" => :build
  end

  # Fix build failure with clang 5+.
  # https://www.cs.unipr.it/mantis/view.php?id=2128
  # http://www.cs.unipr.it/git/gitweb.cgi?p=ppl/ppl.git;a=commit;h=c39f6a07b51f89e365b05ba4147aa2aa448febd7
  # since 401 error on the `www.cs.unipr.it` links adopt the patch from macports
  # patch reference, https://github.com/macports/macports-ports/commit/e5de9cc65a8e91fcbb9a3d90911569169f0ccf88
  patch :DATA

  # Fix -flat_namespace being used on Big Sur and later.
  patch do
    file "Patches/libtool/configure-pre-0.4.2.418-big_sur.diff"
    type :unofficial
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--with-gmp=#{formula_opt_prefix("gmp")}",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <ppl_c.h>
      #ifndef PPL_VERSION_MAJOR
      #error "No PPL header"
      #endif
      int main() {
        ppl_initialize();
        return ppl_finalize();
      }
    C
    system ENV.cc, "test.c", "-L#{lib}", "-lppl_c", "-lppl", "-o", "test"
    system "./test"
  end
end

__END__
diff --git a/src/Determinate_inlines.hh b/src/Determinate_inlines.hh
index c918b23..de672a0 100644
--- a/src/Determinate_inlines.hh
+++ b/src/Determinate_inlines.hh
@@ -289,8 +289,8 @@ operator()(Determinate& x, const Determinate& y) const {

 template <typename PSET>
 template <typename Binary_Operator_Assign>
-inline
-Determinate<PSET>::Binary_Operator_Assign_Lifter<Binary_Operator_Assign>
+inline typename
+Determinate<PSET>::template Binary_Operator_Assign_Lifter<Binary_Operator_Assign>
 Determinate<PSET>::lift_op_assign(Binary_Operator_Assign op_assign) {
   return Binary_Operator_Assign_Lifter<Binary_Operator_Assign>(op_assign);
 }
diff --git a/src/OR_Matrix_inlines.hh b/src/OR_Matrix_inlines.hh
index a5f2856..560f8d6 100644
--- a/src/OR_Matrix_inlines.hh
+++ b/src/OR_Matrix_inlines.hh
@@ -97,7 +97,7 @@ OR_Matrix<T>::Pseudo_Row<U>::Pseudo_Row(const Pseudo_Row<V>& y)

 template <typename T>
 template <typename U>
-inline OR_Matrix<T>::Pseudo_Row<U>&
+inline typename OR_Matrix<T>::template Pseudo_Row<U>&
 OR_Matrix<T>::Pseudo_Row<U>::operator=(const Pseudo_Row& y) {
   first = y.first;
 #if PPL_OR_MATRIX_EXTRA_DEBUG
