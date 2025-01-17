class SshVault < Formula
  desc "Encrypt/decrypt using SSH keys"
  homepage "https://ssh-vault.com/"
  url "https://github.com/ssh-vault/ssh-vault/archive/0.12.8.tar.gz"
  sha256 "db20269f43ecd98064cef784ef3c7aba3e0eb25ad88ee7449ba2d3d71f13b191"
  license "BSD-3-Clause"
  head "https://github.com/ssh-vault/ssh-vault.git", branch: "master"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "3d31b872e937be5b52e321628ff7f05471c25f42e72dc3e4566580d919613c30"
    sha256 cellar: :any_skip_relocation, big_sur:       "fcb7faca3f1ac56161e9ea91a7e543cf705222d1432d866a7127746f869b79ba"
    sha256 cellar: :any_skip_relocation, catalina:      "8f4fc6e1e12a6eb2cff23b48c34568f2643d6c4570160c459e3ce79b66c5d7a5"
    sha256 cellar: :any_skip_relocation, mojave:        "b3d07f9f64964782d4bc5d1b20218e016f8d4ee07bbb99a35fc5b1b0a0baa903"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e407343984219161b3fcbca1a4574fa199d42b32dd96f34f9926f37999ccf200" # linuxbrew-core
  end

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.version=#{version}"
    system "go", "build", *std_go_args(ldflags: ldflags), "cmd/ssh-vault/main.go"
  end

  test do
    output = shell_output("echo hi | #{bin}/ssh-vault -u new create")
    fingerprint = output.split("\n").first.split(";").last
    cmd = "#{bin}/ssh-vault -k https://ssh-keys.online/key/#{fingerprint} view"
    output = pipe_output(cmd, output, 0)
    assert_equal "hi", output.chomp
  end
end
