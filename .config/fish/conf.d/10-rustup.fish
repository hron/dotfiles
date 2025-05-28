# rustup setup
set cargo_bin "$HOME/.cargo/bin"
if [ -d $cargo_bin ]
    set -gx PATH "$cargo_bin:$PATH"
end
