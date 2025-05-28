# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ]
    set -gx PATH "$HOME/bin:$PATH"
end

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ]
    set -gx PATH "$HOME/.local/bin:$PATH"
end
