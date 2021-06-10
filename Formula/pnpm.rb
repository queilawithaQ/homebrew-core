class Pnpm < Formula
  require "language/node"

  desc "📦🚀 Fast, disk space efficient package manager"
  homepage "https://pnpm.js.org"
  url "https://registry.npmjs.org/pnpm/-/pnpm-6.7.5.tgz"
  sha256 "dac12a0c586c5a7ec4410e9470dbdf9ceed5d95547719c5ece3c1c371f251743"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "5aa6473f4fdc431ca349653751c2a16b9e23290618eea96bf41466ba5418e666"
    sha256 cellar: :any_skip_relocation, big_sur:       "4f6df7c11774a95cd6d9d33b0b7179fa56fe4904ce0838d71abfb4533876cea7"
    sha256 cellar: :any_skip_relocation, catalina:      "4f6df7c11774a95cd6d9d33b0b7179fa56fe4904ce0838d71abfb4533876cea7"
    sha256 cellar: :any_skip_relocation, mojave:        "4f6df7c11774a95cd6d9d33b0b7179fa56fe4904ce0838d71abfb4533876cea7"
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    system "#{bin}/pnpm", "init", "-y"
    assert_predicate testpath/"package.json", :exist?, "package.json must exist"
  end
end
