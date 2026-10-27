class Terraform-provider-libvirt < Formula
  desc "Terraform provisioning with Linux KVM using libvirt"
  homepage "https://example.org/terraform-provider-libvirt"
  version "0.9.9"
  url "http://127.0.0.1:8080/brew/bottles/terraform-provider-libvirt--0.9.9.loongarch64.bottle.tar.gz"
  sha256 "ae2f62b8c5687e1c006a214758dbb8bc2c5f735ba17c010b2d40a20ed88c73cc"

  def install
    bin.install "terraform-provider-libvirt"
  end

  test do
    system "#{bin}/terraform-provider-libvirt"
  end
end
