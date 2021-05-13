class Zellij < Formula
  desc "Pluggable terminal workspace, with terminal multiplexer as the base feature"
  homepage "https://zellij.dev"
  url "https://github.com/zellij-org/zellij/archive/refs/tags/v0.8.0.tar.gz"
  sha256 "850d1a68219debdb4e05f7f58e70b31f440425247caaa1b29b9be1b6c7869207"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "20b80c378d3cd4e583be3666835ccb5c5340a52977a2c81c9df572464d8bc02e"
    sha256 cellar: :any_skip_relocation, big_sur:       "cb880aba2e59c61ad0be14f360bbee48911d8814e9604cf56daa29900b6a6df5"
    sha256 cellar: :any_skip_relocation, catalina:      "9b357757755d585d7529dbd1d5a066673d34e5dea93de84578e7624ff78f8a1a"
    sha256 cellar: :any_skip_relocation, mojave:        "3b43e7d15946e12710e191411daa026cc618fb531c3ce422821113d4222fc930"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args

    (bash_completion/"zellij").write Utils.safe_popen_read("#{bin}/zellij", "generate-completion", "bash")
    (zsh_completion/"_zellij").write Utils.safe_popen_read("#{bin}/zellij", "generate-completion", "zsh")
    (fish_completion/"zellij.fish").write Utils.safe_popen_read("#{bin}/zellij", "generate-completion", "fish")
  end

  test do
    assert_match(/keybinds:.*/, shell_output("#{bin}/zellij setup --dump-config", 1))
    assert_match("zellij #{version}", shell_output("#{bin}/zellij --version"))
  end
end
