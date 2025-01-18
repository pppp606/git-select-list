#!/bin/bash

toggle_selection() {
  local current_option="$1"
  if [[ " ${selected[@]} " =~ " ${current_option} " ]]; then
    selected=("${selected[@]/${current_option}/}")
  else
    selected+=("${current_option}")
  fi
}

toggle_all_selection() {
  if [ ${#selected[@]} -eq ${#options[@]} ]; then
    selected=()
    echo "All selections cleared."
  else
    selected=("${options[@]}")
    echo "All items selected."
  fi
}

if [ -z "$1" ]; then
  echo "Usage: $0 <add|stash|stash apply|stash drop>"
  exit 1
fi

ACTION=$1
SUBACTION=$2

case "$ACTION" in
  add)
    files=($(git status --short | awk '{print $2}'))
    if [ ${#files[@]} -eq 0 ]; then
      echo "No modified files found."
      exit 0
    fi
    added_files=($(git diff --cached --name-only))
    selected=("${added_files[@]}")
    options=("${files[@]}")
    ;;
  stash)
    if [ "$SUBACTION" == "apply" ] || [ "$SUBACTION" == "drop" ]; then
      options=($(git stash list | awk -F: '{print $1}'))
      if [ ${#options[@]} -eq 0 ]; then
        echo "No stashes found."
        exit 0
      fi
    else
      files=($(git status --short | awk '{print $2}'))
      if [ ${#files[@]} -eq 0 ]; then
        echo "No modified files found to stash."
        exit 0
      fi
      options=("${files[@]}")
    fi
    ;;
  *)
    echo "Invalid action: $ACTION"
    echo "Valid actions: add, stash, stash apply, stash drop"
    exit 1
    ;;
esac

current=0
tput civis

draw_menu() {
  clear
  echo ""
  echo "Use ↑/↓ to move, 'a' or 's' to select, 'u' to select all, and Enter or Space to confirm."
  echo ""
  for i in "${!options[@]}"; do
    if [ $i -eq $current ]; then
      if [[ " ${selected[@]} " =~ " ${options[$i]} " ]]; then
        echo "  [x] > ${options[$i]}"
      else
        echo "  [ ] > ${options[$i]}"
      fi
    else
      if [[ " ${selected[@]} " =~ " ${options[$i]} " ]]; then
        echo "  [x]   ${options[$i]}"
      else
        echo "  [ ]   ${options[$i]}"
      fi
    fi
  done
}

handle_input() {
  read -rsn1 input

  if [[ -z "$input" ]]; then
    return 1
  fi

  case "$input" in
    $'\x1b')
      read -rsn2 key
      case "$key" in
        "[A")
          ((current--))
          if [ $current -lt 0 ]; then
            current=$((${#options[@]} - 1))
          fi
          ;;
        "[B")
          ((current++))
          if [ $current -ge ${#options[@]} ]; then
            current=0
          fi
          ;;
      esac
      ;;
    "a")
      toggle_selection "${options[$current]}"
      ;;
    "s")
      toggle_selection "${options[$current]}"
      ;;
    "u")
      toggle_all_selection
      ;;
    *)
      ;;
  esac
  return 0
}

while true; do
  draw_menu
  handle_input || break
done

tput cnorm

if [ ${#selected[@]} -gt 0 ]; then
  case "$ACTION" in
    add)
      echo "Adding the following files:"
      printf '%s\n' "${selected[@]}"
      git add "${selected[@]}"
      ;;
    stash)
      if [ "$SUBACTION" == "apply" ]; then
        echo "Applying the following stashes:"
        printf '%s\n' "${selected[@]}"
        for stash in "${selected[@]}"; do
          git stash apply "$stash"
        done
      elif [ "$SUBACTION" == "drop" ]; then
        echo "Dropping the following stashes:"
        printf '%s\n' "${selected[@]}"
        for stash in "${selected[@]}"; do
          git stash drop "$stash"
        done
      else
        echo "Stashing the following files:"
        printf '%s\n' "${selected[@]}"
        git stash push -m "Selected stash" -- "${selected[@]}"
      fi
      ;;
  esac
else
  echo "No items were selected."
fi
