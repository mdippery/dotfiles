IRB.conf[:PROMPT][:MY_PROMPT]= {
  :AUTO_INDENT => true,
  :PROMPT_I    => "\e[030;1m>>>\e[0m ",
  :PROMPT_S    => "\e[030;1m...\e[0m ",
  :PROMPT_C    => "\e[030;1m...\e[0m ",
  :RETURN      => "%s\n",
}

IRB.conf[:PROMPT_MODE] = :MY_PROMPT

xdg_state_home = ENV['XDG_STATE_HOME'] || "#{Dir.home}/.local/state"
ruby_state_home = "#{xdg_state_home}/ruby"
irb_history_file = "#{ruby_state_home}/irb_history"
IRB.conf[:HISTORY_FILE] = irb_history_file
