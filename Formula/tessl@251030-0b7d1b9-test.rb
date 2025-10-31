class TesslAT2510300b7d1b9Test < Formula
  desc "CLI and MCP to provide coding agents the context they are missing"
  homepage "https://tessl.io"
  url "https://install.tessl.io/releases/251030-0b7d1b9-test.tgz"
  sha256 "ec53215f2b817115221aedbc4c15266a665f419b3de0224c05886651d8a0ea32"
  license ""

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  def post_install
    npm_root = Utils.safe_popen_read("npm", "root", "-g").strip rescue nil
    has_global_npm_installed = !!npm_root && (Pathname.new(npm_root)/"@tessl/cli")&.exist?
    return opoo <<~EOS if has_global_npm_installed
      Existing global npm install detected! Consider removing:
        #{Tty.send(:red)}npm uninstall -g @tessl/cli#{Tty.reset}
    EOS

    brew_bin = "#{opt_bin}/tessl"
    which_list = Utils.safe_popen_read("bash", "-lc", "which -a tessl 2>/dev/null").lines.map(&:strip).uniq
    has_old_bin_installed = which_list.any? && which_list.first != brew_bin
    opoo <<~EOS if has_old_bin_installed
      More than one `#{Tty.send(:green)}tessl#{Tty.reset}` found on the $PATH:
        First match: #{Tty.send(:red)}#{which_list.first}#{Tty.reset}
        Homebrew:    #{Tty.send(:green)}#{brew_bin}#{Tty.reset}
      Consider removing to avoid conflicts with Homebrew's installation.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/foo --version")
  end
end
