class Sbt < Formula
  desc "Build tool for Scala projects"
  homepage "https://www.scala-sbt.org/"
  url "https://github.com/sbt/sbt/releases/download/v1.4.9/sbt-1.4.9.tgz"
  mirror "https://sbt-downloads.cdnedge.bluemix.net/releases/v1.4.9/sbt-1.4.9.tgz"
  sha256 "95468119f7641499367330a60a4b8a6211e6ea7f8bde7d647c67b19dd8fddb6e"
  license "Apache-2.0"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle :unneeded

  depends_on "openjdk"

  def install
    inreplace "bin/sbt" do |s|
      s.gsub! 'etc_sbt_opts_file="/etc/sbt/sbtopts"', "etc_sbt_opts_file=\"#{etc}/sbtopts\""
      s.gsub! "/etc/sbt/sbtopts", "#{etc}/sbtopts"
    end

    libexec.install "bin"
    etc.install "conf/sbtopts"

    (bin/"sbt").write_env_script libexec/"bin/sbt", Language::Java.overridable_java_home_env
    (bin/"sbtn").write_env_script libexec/"bin/sbtn-x86_64-apple-darwin", Language::Java.overridable_java_home_env
  end

  def caveats
    <<~EOS
      You can use $SBT_OPTS to pass additional JVM options to sbt.
      Project specific options should be placed in .sbtopts in the root of your project.
      Global settings should be placed in #{etc}/sbtopts
    EOS
  end

  test do
    ENV.append "_JAVA_OPTIONS", "-Dsbt.log.noformat=true"
    system("#{bin}/sbt", "--sbt-create", "about")
    assert_match version.to_s, shell_output("#{bin}/sbt sbtVersion")
    system "#{bin}/sbtn", "about"
    system "#{bin}/sbtn", "shutdown"
  end
end
