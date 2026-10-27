class Todoist < Formula
  desc "Todoist CLI Client. I ❤️ Todoist and CLI."
  homepage "https://example.org/todoist"
  version "0.24.0"
  url "http://127.0.0.1:8080/brew/bottles/todoist--0.24.0.loongarch64.bottle.tar.gz"
  sha256 "43be94532d274bcc2905c8d4600c3bdfacef940eddba6cb9370115196725ccfb"

  def install
    bin.install "todoist"
  end

  test do
    system "#{bin}/todoist"
  end
end
