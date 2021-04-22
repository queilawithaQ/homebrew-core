class Numpy < Formula
  desc "Package for scientific computing with Python"
  homepage "https://www.numpy.org/"
  url "https://files.pythonhosted.org/packages/d2/48/f445be426ccd9b2fb64155ac6730c7212358882e589cd3717477d739d9ff/numpy-1.20.1.zip"
  sha256 "3bc63486a870294683980d76ec1e3efc786295ae00128f9ea38e2c6e74d5a60a"
  license "BSD-3-Clause"
  revision 1
  head "https://github.com/numpy/numpy.git"

  bottle do
    sha256 cellar: :any, arm64_big_sur: "9279b94988655c47bdb9edc39b979aa5db413b20c5f3a779361ac4a7f9fa7e3c"
    sha256 cellar: :any, big_sur:       "2a6db741eeeb0bcc43abf0140035b2e1d5ffe5a9c56aefbd465113dce180afd1"
    sha256 cellar: :any, catalina:      "6ed8007be92b08b16ae5a7614628f58414772adbf7357fde99160023adffb15f"
    sha256 cellar: :any, mojave:        "cd3b07c7bbaca5aa08394c579440c0e2c691adfb53b055d319d1f54a69be6250"
  end

  depends_on "cython" => :build
  depends_on "gcc" => :build # for gfortran
  depends_on "openblas"
  depends_on "python@3.9"

  def install
    openblas = Formula["openblas"].opt_prefix
    ENV["ATLAS"] = "None" # avoid linking against Accelerate.framework
    ENV["BLAS"] = ENV["LAPACK"] = "#{openblas}/lib/#{shared_library("libopenblas")}"

    config = <<~EOS
      [openblas]
      libraries = openblas
      library_dirs = #{openblas}/lib
      include_dirs = #{openblas}/include
    EOS

    Pathname("site.cfg").write config

    xy = Language::Python.major_minor_version Formula["python@3.9"].opt_bin/"python3"
    ENV.prepend_create_path "PYTHONPATH", Formula["cython"].opt_libexec/"lib/python#{xy}/site-packages"

    system Formula["python@3.9"].opt_bin/"python3", *Language::Python.setup_install_args(prefix),
      "build", "--fcompiler=gnu95", "--parallel=#{ENV.make_jobs}"
  end

  test do
    system Formula["python@3.9"].opt_bin/"python3", "-c", <<~EOS
      import numpy as np
      t = np.ones((3,3), int)
      assert t.sum() == 9
      assert np.dot(t, t).sum() == 27
    EOS
  end
end
