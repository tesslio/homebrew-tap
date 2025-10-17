class Tessl < Formula
  desc "CLI and MCP to provide coding agents the context they are missing"
  homepage "https://tessl.io"
  url "https://registry.npmjs.org/@tessl/cli/-/cli-0.28.0.tgz"
  sha256 "d6bc590511b83fc058af87e542e2c721d3ea16ceb907ebea6d89d53c44413800"
  license ""

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/foo --version")
  end
end
