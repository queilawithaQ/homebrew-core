class NodeSass < Formula
  require "language/node"

  desc "JavaScript implementation of a Sass compiler"
  homepage "https://github.com/sass/dart-sass"
  url "https://registry.npmjs.org/sass/-/sass-1.44.0.tgz"
  sha256 "b9aa8a6b9ede9f8187e3405e0df2480e7a759c4a77bdf45a666526c3c49e556c"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_monterey: "1632207b2369cbd56e0b3d68b3c21f868cbdbdf4265adc0c0ee42d1b776cda06"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "1632207b2369cbd56e0b3d68b3c21f868cbdbdf4265adc0c0ee42d1b776cda06"
    sha256 cellar: :any_skip_relocation, monterey:       "1632207b2369cbd56e0b3d68b3c21f868cbdbdf4265adc0c0ee42d1b776cda06"
    sha256 cellar: :any_skip_relocation, big_sur:        "1632207b2369cbd56e0b3d68b3c21f868cbdbdf4265adc0c0ee42d1b776cda06"
    sha256 cellar: :any_skip_relocation, catalina:       "1632207b2369cbd56e0b3d68b3c21f868cbdbdf4265adc0c0ee42d1b776cda06"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "dab99aa5a8a25cccc376f11177415e155b70fc6435df920213a07804a5a90a84"
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    (testpath/"test.scss").write <<~EOS
      div {
        img {
          border: 0px;
        }
      }
    EOS

    assert_equal "div img{border:0px}",
    shell_output("#{bin}/sass --style=compressed test.scss").strip
  end
end
