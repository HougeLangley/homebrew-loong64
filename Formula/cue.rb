class Cue < Formula
  desc "The home of the CUE language! Validate and define text-based and dynamic configuration"
  homepage "https://example.org/cue"
  version "0.17.1"
  url "http://127.0.0.1:8080/brew/bottles/cue--0.17.1.loongarch64.bottle.tar.gz"
  sha256 "71951bb87488b28596aa1053d2b0f3e6b85a632bf73464c964aec06dff040575"

  def install
    bin.install "cue"
  end

  test do
    system "#{bin}/cue"
  end
end
