class Namloader < Formula
  desc "Namloader VST3 plugin - template reusable pour inference NAM"
  homepage "https://github.com/Chopiou/nam-vst3"
  url "https://github.com/Chopiou/nam-vst3/releases/download/v0.0.18/Namloader-v0.0.18-macos-universal.vst3.tar.gz"
  sha256 "6b53f86a008cc037c915e32971ecc0583b963689b37c724e296b962218221bdc"
  version "0.0.18"
  license "MIT"

  def install
    # Install the .vst3 bundle into the Cellar (sandbox-safe)
    src = buildpath.to_s
    odie "NAMLoader.vst3 not found at #{src}" unless File.directory?(src)

    # Install to prefix/Namloader.vst3 (sandbox-safe)
    dest = prefix/"Namloader.vst3"
    FileUtils.rm_rf(dest) if File.exist?(dest)
    system "ditto", buildpath.to_s, dest

    # Create INSTALL_RECEIPT.json
    FileUtils.mkdir_p(prefix)
    File.write(File.join(prefix, "INSTALL_RECEIPT.json"),
      JSON.generate({
        "plugin" => "Namloader.vst3",
        "installed_to" => dest.to_s,
        "version" => version
      }))
  end

  def post_install
    # After installation (outside sandbox), create the VST3 folder and symlink
    # System-wide VST3 directory: /Library/Audio/Plug-Ins/VST3/Chopiou
    dest_dir = "/Library/Audio/Plug-Ins/VST3/Chopiou"
    dest = File.join(dest_dir, "Namloader.vst3")
    FileUtils.mkdir_p(dest_dir)
    FileUtils.rm_rf(dest) if File.exist?(dest)
    FileUtils.ln_s(opt_prefix/"Namloader.vst3", dest)
  end

  def caveats
    <<~EOS
      Plugin installe dans /Library/Audio/Plug-Ins/VST3/Chopiou/Namloader.vst3
      Redemarrez votre DAW (Reaper, etc.) pour le detecter.
      Note: nécessite sudo pour /Library, donc lance : brew install --cask namloader
      Ou installe manuellement : sudo ln -s #{opt_prefix}/Namloader.vst3 /Library/Audio/Plug-Ins/VST3/Chopiou/Namloader.vst3
    EOS
  end

  def uninstall
    # Remove symlink on uninstall
    dest = "/Library/Audio/Plug-Ins/VST3/Chopiou/Namloader.vst3"
    FileUtils.rm_f(dest) if File.symlink?(dest)
  end

  test do
    assert_predicate Dir, :directory?, opt_prefix/"Namloader.vst3"
  end
end
