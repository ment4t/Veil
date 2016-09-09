#!/bin/bash

# Global Variables
gitcmd=$(which git)
veildir=$(dirname ${0})
unset veilopts

# Title Function
func_title(){
  # Clear (For Prettyness)
  clear

  # Print Title
  echo '================================================================'
  echo '                      Veil Project Installer                    '
  echo '================================================================'
}

# Veil Framework Clone Function
func_install(){
  func_title
  cd ${veildir}
  echo '[*] Cloning Veil Framework Repos'
  ${gitcmd} clone https://github.com/Veil-Framework/Veil-Evasion.git
  cd Veil-Evasion/setup && ./setup.sh ${veilopts:-}
  cd ../..
  ${gitcmd} clone https://github.com/Veil-Framework/PowerTools.git
  ${gitcmd} clone https://github.com/Veil-Framework/Veil-Pillage.git
  cd Veil-Pillage && ./update.py
  cd ..
  ${gitcmd} clone https://github.com/Veil-Framework/Veil-Catapult.git
  cd Veil-Catapult && ./setup.sh
  cd ..
  ${gitcmd} clone https://github.com/Veil-Framework/Veil-Ordnance.git
  echo
  echo '[*] All Repos Cloned!'
}

# Veil Framework Clone Function
func_update(){
  func_title
  cd ${veildir}
  echo '[*] Updating Veil Framework Repos'
  echo '[*] Updating Veil-Evasion'
  cd Veil-Evasion && ${gitcmd} pull
  cd ..
  echo ' [*] Updating PowerTools'
  cd PowerTools && ${gitcmd} pull
  cd ..
  echo '[*] Updating Veil-Pillage'
  cd Veil-Pillage && ${gitcmd} pull
  cd ..
  echo '[*] Updating Veil-Catapult'
  cd Veil-Catapult && ${gitcmd} pull
  cd ..
  echo '[*] Updating Veil-Ordnance'
  cd Veil-Ordnance && ${gitcmd} pull
  cd ..
  echo
  echo '[*] All Repos Cloned!'
}


# Select Function and Menu Statement
func_title
case ${1} in
  -s)
    case ${2} in
       -c)
         veilopts="--silent"
         ;;
       *)
         printf '%s\n' "[!] The -s switch is intended to be used with the -c \
           (Clone) option." >&2
         exit 3
    esac
    echo
    func_install
    ;;
  -c)
    case ${2} in
       -s)
         veilopts="--silent"
    esac
    echo
    func_install
    ;;
  -u)
    echo
    func_update
    ;;
  *)
    echo
    echo "[Usage]...: ${0} [OPTION]"
    echo '[Options].: -c = Clone Veil Framework Repos'
    echo '            -u = Update Veil Framework Repos'
    echo '[Optional]: -s = Silent install of Veil-Evasion (with -c switch)'
    echo
esac
