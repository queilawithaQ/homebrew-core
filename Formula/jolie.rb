class Jolie < Formula
  desc "Service-oriented programming language"
  homepage "https://www.jolie-lang.org/"
  url "https://github.com/jolie/jolie/releases/download/v1.10.1/jolie-1.10.1.jar"
  sha256 "e47f3b4d81694752fce64e5ca4f4895909b6e5346e35e8dd65e59b798929140f"
  license "LGPL-2.1-only"

  bottle do
    sha256 cellar: :any_skip_relocation, all: "fc4407a49e94303c4024ce0f3e6f32ad91556772c6c7290da68f832be27ce3a2"
  end

  depends_on "openjdk"

  def install
    system Formula["openjdk"].opt_bin/"java",
    "-jar", "jolie-#{version}.jar",
    "--jolie-home", libexec,
    "--jolie-launchers", libexec/"bin"
    bin.install Dir["#{libexec}/bin/*"]
    bin.env_script_all_files libexec/"bin",
      JOLIE_HOME: "${JOLIE_HOME:-#{libexec}}",
      JAVA_HOME:  "${JAVA_HOME:-#{Formula["openjdk"].opt_prefix}}"
  end

  test do
    file = testpath/"test.ol"
    file.write <<~EOS
      from Console import Console, ConsoleIface

      interface PowTwoInterface { OneWay: powTwo( int ) }

      service main(){

        outputPort Console { interfaces: ConsoleIface }
        embed Console in Console

        inputPort In {
          location: "local://testPort"
          interfaces: PowTwoInterface
        }

        outputPort Self {
          location: "local://testPort"
          interfaces: PowTwoInterface
        }

        init {
          powTwo@Self( 4 )
        }

        main {
          powTwo( x )
          println@Console( x * x )()
        }

      }
    EOS

    out = shell_output("#{bin}/jolie #{file}").strip

    assert_equal "16", out
  end
end
