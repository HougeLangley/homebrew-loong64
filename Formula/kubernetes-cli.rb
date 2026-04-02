class KubernetesCli < Formula
  desc "Kubernetes command-line interface"
  homepage "https://kubernetes.io/"
  url "https://github.com/kubernetes/kubernetes.git",
      tag:      "v1.32.2",
      revision: "67a1b9c8e6f92f00090c277c6f7f2df8be6c0a4d"
  license "Apache-2.0"
  head "https://github.com/kubernetes/kubernetes.git", branch: "master"

  depends_on "bash" => :build
  depends_on "coreutils" => :build
  depends_on "go" => :build

  def install
    ENV["FORCE_HOST_GO"] = "1"
    
    cpu = Hardware::CPU.loongarch? ? "loongarch64" : Hardware.oldest_cpu
    ENV["KUBE_BUILD_PLATFORMS"] = "linux/#{cpu}"
    
    system "make", "WHAT=cmd/kubectl"
    bin.install "_output/bin/kubectl"
    
    generate_completions_from_executable(bin/"kubectl", "completion", base_name: "kubectl")
  end

  test do
    system bin/"kubectl", "version", "--client"
  end
end
