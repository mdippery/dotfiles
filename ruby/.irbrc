IRB.conf[:PROMPT][:MY_PROMPT]= {
  :AUTO_INDENT => true,
  :PROMPT_I    => "\e[030;1m>>>\e[0m ",
  :PROMPT_S    => "\e[030;1m...\e[0m ",
  :PROMPT_C    => "\e[030;1m...\e[0m ",
  :RETURN      => "%s\n",
}

IRB.conf[:PROMPT_MODE] = :MY_PROMPT
