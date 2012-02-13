#!/usr/bin/env bash
git push
cap deploy:web:disable
echo "→ web disabled, starting deploy"
cap deploy
echo "→ deploy finished, enabling web"
cap deploy:web:enable
echo "√ deploy finished"
