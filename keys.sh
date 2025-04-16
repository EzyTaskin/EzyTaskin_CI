#!/bin/bash -e

for (( i=1; i<=$#; i++)); do
case ${!i} in
    --frontend)
    KEY_FRONTEND=1
    ;;
    --backend)
    KEY_BACKEND=1
    ;;
    --ci)
    KEY_CI=1
    ;;
    --all)
    KEY_FRONTEND=1
    KEY_BACKEND=1
    KEY_CI=1
    ;;
    *)
            # unknown option
    echo "Unknown option: ${!i}"
    exit 1
    ;;
esac
done

mkdir -p $HOME/.ssh

if [[ "$KEY_BACKEND" == 1 ]]; then
    echo "$EZY_BACKEND" > $HOME/.ssh/ezy_backend

    echo "
        Host backend.ezytaskin
            Hostname github.com
            IdentityFile=$HOME/.ssh/ezy_backend
            User git
    " >> $HOME/.ssh/config
fi

if [[ "$KEY_FRONTEND" == 1 ]]; then
    echo "$EZY_FRONTEND" > $HOME/.ssh/ezy_frontend

    echo "
        Host frontend.ezytaskin
            Hostname github.com
            IdentityFile=$HOME/.ssh/ezy_frontend
            User git
    " >> $HOME/.ssh/config
fi

if [[ "$KEY_CI" == 1 ]]; then
    echo "$EZY_CI" > $HOME/.ssh/ezy_ci

    echo "
        Host ci.ezytaskin
            Hostname github.com
            IdentityFile=$HOME/.ssh/ezy_ci
            User git
    " >> $HOME/.ssh/config
fi

chmod 0600 $HOME/.ssh/ezy*
