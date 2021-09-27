require "language/node"

class Whistle < Formula
  desc "HTTP, HTTP2, HTTPS, Websocket debugging proxy"
  homepage "https://github.com/avwo/whistle"
  url "https://registry.npmjs.org/whistle/-/whistle-2.7.23.tgz"
  sha256 "15acea1ad8c5d577fd40970bc387413285d9091d64427f3348f69fa41347161e"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b009808b9f550bda0487884520c7e5698b5d51a071df95d6afc7131a91501f27" # linuxbrew-core
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    (testpath/"package.json").write('{"name": "test"}')
    system bin/"whistle", "start"
    system bin/"whistle", "stop"
  end
end
