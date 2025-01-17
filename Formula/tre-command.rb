class TreCommand < Formula
  desc "Tree command, improved"
  homepage "https://github.com/dduan/tre"
  url "https://github.com/dduan/tre/archive/v0.3.6.tar.gz"
  sha256 "c372573a6325288b9b23dcd20d1cb100ad275f5b0636a7328395352b3549dd71"
  license "MIT"
  head "https://github.com/dduan/tre.git", branch: "main"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "27cba0da0af50bba24136d9522eb88378be6a41aa08fc8e7d32d1e8a51e4a566"
    sha256 cellar: :any_skip_relocation, big_sur:       "95b74502a71f06fd0d836710b7fb706cc32348fe2db788b4ea4b58a39690e840"
    sha256 cellar: :any_skip_relocation, catalina:      "65fd03a686ac215dcf9228312238b4c0447823f99c9a45074387d3322b9452df"
    sha256 cellar: :any_skip_relocation, mojave:        "f1f321409d7785cf56267748682eae4572a99382bebf1fd187ac30e70c5cebda"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "50d49842166e62e04efcb3dd627f3640789c6c7592666069caecd78b9d50749f" # linuxbrew-core
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
    man1.install "manual/tre.1"
  end

  test do
    (testpath/"foo.txt").write("")
    assert_match("── foo.txt", shell_output("#{bin}/tre"))
  end
end
