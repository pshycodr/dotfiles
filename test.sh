#!/usr/bin/env bash
set -e

# ---------- Colors ----------
RED="\033[1;31m"
GREEN="\033[1;32m"
CYAN="\033[1;36m"
RESET="\033[0m"

# ---------- Spinner ----------
spinner() {
  local pid=$1
  local delay=0.08
  local spinstr='|/-\'
  while ps -p $pid > /dev/null 2>&1; do
    local temp=${spinstr#?}
    printf " [%c]  " "$spinstr"
    spinstr=$temp${spinstr%"$temp"}
    sleep $delay
    printf "\b\b\b\b\b\b"
  done
  printf "    \b\b\b\b"
}

run_step() {
  echo -e "${CYAN}>> $1${RESET}"
  shift
  ("$@" >/dev/null 2>&1) &
  spinner $!
  wait $!
  echo -e "${GREEN}✔ Done${RESET}"
}

# ---------- Fake tasks ----------
fake_task_short() { sleep 1; }
fake_task_medium() { sleep 2; }
fake_task_long() { sleep 3; }

# ---------- Demo ----------
echo -e "${CYAN}Starting animation test...${RESET}"

run_step "Initializing environment" fake_task_short
run_step "Checking dependencies" fake_task_medium
run_step "Loading modules" fake_task_long
run_step "Applying configuration" fake_task_medium
run_step "Finalizing setup" fake_task_short

echo -e "${GREEN}Animation test complete.${RESET}"
