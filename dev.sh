#!/bin/bash
# Lance browser-sync + auto-pull en parallèle
# Usage: ./dev.sh [branche]  (défaut: branche courante)

BRANCH=${1:-$(git rev-parse --abbrev-ref HEAD)}
echo "🎵 Santos & Mimi — dev server"
echo "📡 Branche suivie : $branch"
echo "🔄 Auto-pull toutes les 4s"
echo "-----------------------------------"

# Pull en boucle en arrière-plan
(while true; do
  git pull origin "$BRANCH" --quiet 2>/dev/null && true
  sleep 4
done) &
PULL_PID=$!

# Lance browser-sync
npx browser-sync start --server --files 'index.html, images/**' --no-notify --open

# Quand on quitte browser-sync (Ctrl+C), on tue aussi le pull
kill $PULL_PID 2>/dev/null
