class CodeServer < Formula
  desc "Access VS Code through the browser"
  homepage "https://github.com/cdr/code-server"
  url "https://registry.npmjs.org/code-server/-/code-server-3.9.1.tgz"
  sha256 "cfd8c6d7ed646fb7efe18a889757352a1271e25749df3519ed51f7c3988f0d3f"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "f4c7d8f17c2d5c4c8519e1a64b800fb9ce7433a9d33364afccd951bc0addd6af"
    sha256 cellar: :any_skip_relocation, big_sur:       "a6472c654d4397de563a78fe879acb3574e3d7855ab999cb03b57fda38b9ac6c"
    sha256 cellar: :any_skip_relocation, catalina:      "66fe382b5b6e48343e5fd0cac224fd9ddeaf78b4fe98b50bb1a4c119c1522336"
    sha256 cellar: :any_skip_relocation, mojave:        "293fc8a3e25dbf476e30e48701f667ba35f74ed0ec0083916e73a34c6e88eb72"
  end

  depends_on "python@3.9" => :build
  depends_on "yarn" => :build
  depends_on "node"

  on_linux do
    depends_on "pkg-config" => :build
    depends_on "libsecret"
    depends_on "libx11"
    depends_on "libxkbfile"
  end

  def install
    system "yarn", "--production", "--frozen-lockfile"
    libexec.install Dir["*"]
    env = { PATH: "#{HOMEBREW_PREFIX}/opt/node/bin:$PATH" }
    (bin/"code-server").write_env_script "#{libexec}/out/node/entry.js", env
  end

  def caveats
    <<~EOS
      The launchd service runs on http://127.0.0.1:8080. Logs are located at #{var}/log/code-server.log.
    EOS
  end

  plist_options manual: "code-server"

  def plist
    <<~EOS
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
        <key>KeepAlive</key>
        <true/>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>ProgramArguments</key>
        <array>
          <string>#{HOMEBREW_PREFIX}/bin/code-server</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
        <key>WorkingDirectory</key>
        <string>#{ENV["HOME"]}</string>
        <key>StandardOutPath</key>
        <string>#{var}/log/code-server.log</string>
        <key>StandardErrorPath</key>
        <string>#{var}/log/code-server.log</string>
      </dict>
      </plist>
    EOS
  end

  test do
    # See https://github.com/cdr/code-server/blob/master/ci/build/test-standalone-release.sh
    system bin/"code-server", "--extensions-dir=.", "--install-extension", "ms-python.python"
    assert_match "ms-python.python",
      shell_output("#{bin/"code-server"} --extensions-dir=. --list-extensions")
  end
end
