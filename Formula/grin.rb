class Grin < Formula
  desc "Minimal implementation of the Mimblewimble protocol"
  homepage "https://grin.mw/"
  url "https://github.com/mimblewimble/grin/archive/v5.1.1.tar.gz"
  sha256 "7968dab97e836cc142310cf626317e2d0de78002c04252ba819ce40fa05748ef"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "04b1548c4e5de7d5a6e13126825937f0f87aad4b81ce155f092798b84a94f9dd"
    sha256 cellar: :any_skip_relocation, big_sur:       "49667390db7e89f2376813b8b0d627721361e9905a16b47dcb7868ec0766a751"
    sha256 cellar: :any_skip_relocation, catalina:      "74529f59d9c4389e763216b1147065a0a54ec2641ad0dc1577475c50a81fdfc4"
    sha256 cellar: :any_skip_relocation, mojave:        "5a9820a6fa169cb81b0767f46fd01875c35b78b297382d1ae6a486d5e5066631"
  end

  depends_on "llvm" => :build # for libclang
  depends_on "rust" => :build

  uses_from_macos "ncurses"

  def install
    ENV["CLANG_PATH"] = Formula["llvm"].opt_bin/"clang"

    system "cargo", "install", *std_cargo_args
  end

  test do
    system bin/"grin", "server", "config"
    assert_predicate testpath/"grin-server.toml", :exist?
  end
end
