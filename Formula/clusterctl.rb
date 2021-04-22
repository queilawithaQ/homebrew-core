class Clusterctl < Formula
  desc "Home for the Cluster Management API work, a subproject of sig-cluster-lifecycle"
  homepage "https://cluster-api.sigs.k8s.io"
  url "https://github.com/kubernetes-sigs/cluster-api/archive/refs/tags/v0.3.14.tar.gz"
  sha256 "fc7c7eb07bce70505721c8bc82ff4b8f111172cdfef94964b7ceac82e45faace"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "5a7c6535dc4831815d681d2d786eab329a5fc9b4b687427540a98191c7393663"
    sha256 cellar: :any_skip_relocation, big_sur:       "af40e87e380e35e3647891635efc12c60494339c65c4c553f0341fe3a319be0f"
    sha256 cellar: :any_skip_relocation, catalina:      "2bf9c2331956328df8e8cb0ea0037ef8786e9201cb1cc0aa372ce295aaeee481"
    sha256 cellar: :any_skip_relocation, mojave:        "4a2c710b1166aeed3a5216ee1747204c2daac183c6a4c1e72e97dbba8a97a5c4"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args, "-o", bin/"clusterctl"
  end

  test do
    output = shell_output("KUBECONFIG=/homebrew.config  #{bin}/clusterctl 2>&1", 1)
    assert_match "invalid configuration: no configuration has been provided", output
  end
end
