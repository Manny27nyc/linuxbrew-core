class Elektra < Formula
  desc "Framework to access config settings in a global key database"
  homepage "https://libelektra.org/"
  url "https://www.libelektra.org/ftp/elektra/releases/elektra-0.9.8.tar.gz"
  sha256 "b1e8908c138b84e788fdff25eab1c2b07e0b422a5fd1667814539ea02f151c58"
  license "BSD-3-Clause"
  head "https://github.com/ElektraInitiative/libelektra.git"

  livecheck do
    url "https://www.libelektra.org/ftp/elektra/releases/"
    regex(/href=.*?elektra[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 arm64_big_sur: "7e1dd629af27f13b6bfe769c221f4c976cb22ad1ac9716601be0c37371633490"
    sha256 big_sur:       "aab3adfe2c4413d61a9b817e32e6eb9f8a13066f219bb4e889601db6a81871ff"
    sha256 catalina:      "08adc201df239e698550c10cc565cba877b4a29656cc120c372e474567dd48f8"
    sha256 mojave:        "3dbb5277e94c3b9e8cc2ad2e1304b8cbe37938f47727a643adf47ff3303bb8f6"
    sha256 x86_64_linux:  "193ffb6dff073f297ad706bd9a3bf17b4f745c82441c4e00cf05e695824e2ff9" # linuxbrew-core
  end

  depends_on "cmake" => :build
  depends_on "doxygen" => :build

  def install
    mkdir "build" do
      system "cmake", "..", "-DBINDINGS=cpp", "-DTOOLS=kdb;",
                            "-DPLUGINS=NODEP", *std_cmake_args
      system "make", "install"
    end

    bash_completion.install "scripts/completion/kdb-bash-completion" => "kdb"
    fish_completion.install "scripts/completion/kdb.fish"
    zsh_completion.install "scripts/completion/kdb_zsh_completion" => "_kdb"
  end

  test do
    output = shell_output("#{bin}/kdb get system:/elektra/version/infos/licence")
    assert_match "BSD", output
    shell_output("#{bin}/kdb plugin-list").split.each do |plugin|
      system "#{bin}/kdb", "plugin-check", plugin
    end
  end
end
