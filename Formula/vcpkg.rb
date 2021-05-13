class Vcpkg < Formula
  desc "C++ Library Manager"
  homepage "https://github.com/microsoft/vcpkg"
  url "https://github.com/microsoft/vcpkg/archive/2020.11-1.tar.gz"
  version "2020.11-1"
  sha256 "dcae747fddfc1540b57d576afd2ad5191611013cce0bf30f184a1535c3d90fbe"
  license "MIT"
  revision 1
  head "https://github.com/microsoft/vcpkg.git"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "0d1d60ffa4f6296a39b11e9324b4ce0e2acf210a95be8da551a6f0bee9a795ee"
    sha256 cellar: :any_skip_relocation, big_sur:       "0392fae50da34c6beeb52fa58ac63792ec4ac75801285f13ca65aa984af5368f"
    sha256 cellar: :any_skip_relocation, catalina:      "d4aada87eb2d5b7cb32214e9a328fc54cbbcb208898adb95b75a51f0bcfc6d11"
    sha256 cellar: :any,                 mojave:        "17881d46973aa1dd96b9fa4e3e5d2b8922febe9be86555639a1f37f8a7eca5cd"
  end

  depends_on "cmake" => :build
  depends_on "ninja" => :build

  on_linux do
    depends_on "gcc" # for C++17
  end

  fails_with gcc: "5"

  if MacOS.version <= :mojave
    depends_on "gcc"
    fails_with :clang do
      cause "'file_status' is unavailable: introduced in macOS 10.15"
    end
  end

  # build fix for arm
  # remove in next release
  patch do
    url "https://github.com/microsoft/vcpkg/commit/7f328aa.patch?full_index=1"
    sha256 "afe40ee3c294b85f062dc1598ff0cd7ae4f550336ac0b13f2a4f0226c50c501e"
  end

  def install
    # fix for conflicting declaration of 'char* ctermid(char*)' on Mojave
    # https://github.com/microsoft/vcpkg/issues/9029
    ENV.prepend "CXXFLAGS", "-D_CTERMID_H_" if MacOS.version == :mojave

    args = %w[-useSystemBinaries -disableMetrics]
    args << "-allowAppleClang" if MacOS.version > :mojave
    system "./bootstrap-vcpkg.sh", *args

    bin.install "vcpkg"
    bin.env_script_all_files(libexec/"bin", VCPKG_ROOT: libexec)
    libexec.install Dir["*.txt", ".vcpkg-root", "{ports,scripts,triplets}"]
  end

  def post_install
    (var/"vcpkg/installed").mkpath
    (var/"vcpkg/packages").mkpath
    ln_s var/"vcpkg/installed", libexec/"installed"
    ln_s var/"vcpkg/packages", libexec/"packages"
  end

  test do
    assert_match "sqlite3", shell_output("#{bin}/vcpkg search sqlite")
  end
end
