class Libcmph < Formula
  desc "C minimal perfect hashing library"
  homepage "https://cmph.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/cmph/v2.0.2/cmph-2.0.2.tar.gz"
  sha256 "365f1e8056400d460f1ee7bfafdbf37d5ee6c78e8f4723bf4b3c081c89733f1e"
  license any_of: ["LGPL-2.1-only", "MPL-1.1"]

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "2880b62a2d698dfd30e18884198d5d430831b70008c61a2963a024ff93a895dd"
  end


  # Fix -flat_namespace being used on Big Sur and later.
  patch do
    file "Patches/libtool/configure-big_sur.diff"
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <cmph.h>
      #include <string.h>
      #include <stdio.h>
      int main(int argc, char **argv)
      {
          unsigned int i = 0;
          const char *vector[] = {"aaaaaaaaaa", "bbbbbbbbbb", "cccccccccc", "dddddddddd", "eeeeeeeeee",
              "ffffffffff", "gggggggggg", "hhhhhhhhhh", "iiiiiiiiii", "jjjjjjjjjj"};
          unsigned int nkeys = 10;
          FILE* mphf_fd = fopen("temp.mph", "w");
          cmph_io_adapter_t *source = cmph_io_vector_adapter((char **)vector, nkeys);
          cmph_config_t *config = cmph_config_new(source);
          cmph_config_set_algo(config, CMPH_BRZ);
          cmph_config_set_mphf_fd(config, mphf_fd);
          cmph_t *hash = cmph_new(config);
          cmph_config_destroy(config);
          cmph_dump(hash, mphf_fd);
          cmph_destroy(hash);
          fclose(mphf_fd);
          mphf_fd = fopen("temp.mph", "r");
          hash = cmph_load(mphf_fd);
          while (i < nkeys) {
              const char *key = vector[i];
              unsigned int id = cmph_search(hash, key, (cmph_uint32)strlen(key));
              fprintf(stdout, "%s %u\\n", key, id);
              i++;
          }
          cmph_destroy(hash);
          cmph_io_vector_adapter_destroy(source);
          fclose(mphf_fd);
          return 0;
      }
    C

    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lcmph", "-o", "test"
    output = shell_output(testpath/"test").lines
    assert_equal 10, output.length
    letters = output.map { |line| line.split.first }
    numbers = output.map { |line| line.split.last.to_i }
    ("a".."j").each { |letter| assert_equal 1, letters.count(letter * 10) }
    (0..9).each { |i| assert_equal 1, numbers.count(i) }
  end
end
