if [[ "$OSTYPE" =~ ^darwin* ]]; then
  export BASH_SILENCE_DEPRECATION_WARNING=1
  if [ -s ~/.bashrc ]; then
      source ~/.bashrc;
  fi
fi
