class RmImproved < Formula
  desc "Command-line deletion tool focused on safety, ergonomics, and performance"
  homepage "https://github.com/nivekuil/rip"
  url "https://github.com/nivekuil/rip/archive/0.13.1.tar.gz"
  sha256 "73acdc72386242dced117afae43429b6870aa176e8cc81e11350e0aaa95e6421"
  license "GPL-3.0-or-later"
  head "https://github.com/nivekuil/rip.git", branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "5e09493b8db07b3e29621cfd7d7ef81b90007fec6378e00fee491a82851ad148"
    sha256 cellar: :any_skip_relocation, big_sur:       "16260eaa3888976a39b9711ea7150d9e7e3afbee0c34efa022b1a2542f5c4bd9"
    sha256 cellar: :any_skip_relocation, catalina:      "6b404b0fe096447d90c21c15140ee9295fdea4060771723e818625e8dcde8e2f"
    sha256 cellar: :any_skip_relocation, mojave:        "cd164204efca72560dcb8d39db760d7e9efbeab5e9bfd0718c6cccd5b022a7f3"
    sha256 cellar: :any_skip_relocation, high_sierra:   "27fa7c0976c9361fae1638f05a0c756603a509a16459db688d2e787ceb123de2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bd4dbbad9f8758a68a65b50a01abf0746f6b06e7043bc4438d743057d786b986" # linuxbrew-core
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    trash = testpath/"trash"
    ENV["GRAVEYARD"] = trash

    source_file = testpath/"testfile"
    deleted_file = Pathname.new File.join(trash, source_file)
    touch source_file

    system "rip", source_file
    assert_match deleted_file.to_s, shell_output("#{bin}/rip -s")
    assert_predicate deleted_file, :exist?

    system "rip", "-u", deleted_file
    assert_predicate source_file, :exist?
  end
end
