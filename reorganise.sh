#!/usr/bin/env bash
# =============================================================================
# reorganise.sh
#
# Migrates the NLP-Course repo from the original 10-session folder structure
# to the 8-session structure.
#
# Run from the ROOT of the repo:
#   chmod +x reorganise.sh
#   ./reorganise.sh
#
# The script is IDEMPOTENT — safe to run multiple times.
# It does NOT delete any files; it only moves and renames.
# Review the git diff after running before committing.
# =============================================================================

set -euo pipefail

ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
SRC="$ROOT/src"

echo "==> Working in: $ROOT"
echo ""

# ── Helper ────────────────────────────────────────────────────────────────────
move_if_exists() {
    local src="$1"
    local dst="$2"
    if [ -e "$src" ]; then
        mkdir -p "$(dirname "$dst")"
        git mv "$src" "$dst" 2>/dev/null || mv "$src" "$dst"
        echo "    moved: $src  →  $dst"
    else
        echo "    skip (not found): $src"
    fi
}

# =============================================================================
# Step 1 — Rename tp02_ngrams → tp02_lm_ngrams
# =============================================================================
echo "── Step 1: rename tp02_ngrams → tp02_lm_ngrams"

if [ -d "$SRC/tp02_ngrams" ] && [ ! -d "$SRC/tp02_lm_ngrams" ]; then
    git mv "$SRC/tp02_ngrams" "$SRC/tp02_lm_ngrams" 2>/dev/null \
        || mv "$SRC/tp02_ngrams" "$SRC/tp02_lm_ngrams"
    echo "    renamed: tp02_ngrams → tp02_lm_ngrams"
fi

# Rename notebook files inside the folder
move_if_exists \
    "$SRC/tp02_lm_ngrams/tp02_ngrams.ipynb" \
    "$SRC/tp02_lm_ngrams/tp02_lm_ngrams.ipynb"

move_if_exists \
    "$SRC/tp02_lm_ngrams/tp02_sol_ngrams.ipynb" \
    "$SRC/tp02_lm_ngrams/tp02_sol_lm_ngrams.ipynb"

# Move the LanguageModels companion notebook here if it lives at src/ root
move_if_exists \
    "$SRC/LanguageModels.ipynb" \
    "$SRC/tp02_lm_ngrams/LanguageModels.ipynb"

echo ""

# =============================================================================
# Step 2 — Merge tp03_naive_bayes + tp04_logistic_regression
#           → tp03_classical_models
# =============================================================================
echo "── Step 2: merge tp03_naive_bayes + tp04_logistic_regression → tp03_classical_models"

mkdir -p "$SRC/tp03_classical_models"

# Move naive Bayes assets
move_if_exists \
    "$SRC/tp03_naive_bayes/naive_bayes.py" \
    "$SRC/tp03_classical_models/naive_bayes.py"

move_if_exists \
    "$SRC/tp03_naive_bayes/tp03_naive_bayes.ipynb" \
    "$SRC/tp03_classical_models/tp03_naive_bayes_legacy.ipynb"

move_if_exists \
    "$SRC/tp03_naive_bayes/tp03_sol_naive_bayes.ipynb" \
    "$SRC/tp03_classical_models/tp03_sol_naive_bayes_legacy.ipynb"

# Move logistic regression assets
move_if_exists \
    "$SRC/tp04_logistic_regression/logistic_regression.py" \
    "$SRC/tp03_classical_models/logistic_regression.py"

move_if_exists \
    "$SRC/tp04_logistic_regression/tp04_logistic_regression.ipynb" \
    "$SRC/tp03_classical_models/tp04_logistic_regression_legacy.ipynb"

move_if_exists \
    "$SRC/tp04_logistic_regression/tp04_sol_logistic_regression.ipynb" \
    "$SRC/tp03_classical_models/tp04_sol_logistic_regression_legacy.ipynb"

# Remove now-empty source folders (only if empty)
rmdir "$SRC/tp03_naive_bayes"       2>/dev/null && echo "    removed empty: tp03_naive_bayes"       || true
rmdir "$SRC/tp04_logistic_regression" 2>/dev/null && echo "    removed empty: tp04_logistic_regression" || true

echo ""

# =============================================================================
# Step 3 — Renumber tp05_embeddings → tp04_embeddings
# =============================================================================
echo "── Step 3: renumber tp05_embeddings → tp04_embeddings"

if [ -d "$SRC/tp05_embeddings" ] && [ ! -d "$SRC/tp04_embeddings" ]; then
    git mv "$SRC/tp05_embeddings" "$SRC/tp04_embeddings" 2>/dev/null \
        || mv "$SRC/tp05_embeddings" "$SRC/tp04_embeddings"
    echo "    renamed: tp05_embeddings → tp04_embeddings"
fi

move_if_exists \
    "$SRC/tp04_embeddings/tp05_embeddings.ipynb" \
    "$SRC/tp04_embeddings/tp04_embeddings.ipynb"

move_if_exists \
    "$SRC/tp04_embeddings/tp05_sol_embeddings.ipynb" \
    "$SRC/tp04_embeddings/tp04_sol_embeddings.ipynb"

echo ""

# =============================================================================
# Step 4 — Drop tp06_ffnn (content absorbed into tp05_rnn intro)
#           Renumber tp07_rnn → tp05_rnn
# =============================================================================
echo "── Step 4: archive tp06_ffnn, renumber tp07_rnn → tp05_rnn"

# Archive (not delete) ffnn material — keep for reference
if [ -d "$SRC/tp06_ffnn" ]; then
    mkdir -p "$ROOT/_archive"
    git mv "$SRC/tp06_ffnn" "$ROOT/_archive/tp06_ffnn_archived" 2>/dev/null \
        || mv "$SRC/tp06_ffnn" "$ROOT/_archive/tp06_ffnn_archived"
    echo "    archived: tp06_ffnn → _archive/tp06_ffnn_archived"
fi

if [ -d "$SRC/tp07_rnn" ] && [ ! -d "$SRC/tp05_rnn" ]; then
    git mv "$SRC/tp07_rnn" "$SRC/tp05_rnn" 2>/dev/null \
        || mv "$SRC/tp07_rnn" "$SRC/tp05_rnn"
    echo "    renamed: tp07_rnn → tp05_rnn"
fi

move_if_exists \
    "$SRC/tp05_rnn/tp07_rnn.ipynb" \
    "$SRC/tp05_rnn/tp05_rnn.ipynb"

move_if_exists \
    "$SRC/tp05_rnn/tp07_sol_rnn.ipynb" \
    "$SRC/tp05_rnn/tp05_sol_rnn.ipynb"

echo ""

# =============================================================================
# Step 5 — Rename tp08_attention → tp06_transformer
# =============================================================================
echo "── Step 5: rename tp08_attention → tp06_transformer"

if [ -d "$SRC/tp08_attention" ] && [ ! -d "$SRC/tp06_transformer" ]; then
    git mv "$SRC/tp08_attention" "$SRC/tp06_transformer" 2>/dev/null \
        || mv "$SRC/tp08_attention" "$SRC/tp06_transformer"
    echo "    renamed: tp08_attention → tp06_transformer"
fi

move_if_exists \
    "$SRC/tp06_transformer/tp08_attention.ipynb" \
    "$SRC/tp06_transformer/tp06_transformer.ipynb"

move_if_exists \
    "$SRC/tp06_transformer/tp08_sol_attention.ipynb" \
    "$SRC/tp06_transformer/tp06_sol_transformer.ipynb"

echo ""

# =============================================================================
# Step 6 — Rename tp09_transformers → tp07_pretraining
# =============================================================================
echo "── Step 6: rename tp09_transformers → tp07_pretraining"

if [ -d "$SRC/tp09_transformers" ] && [ ! -d "$SRC/tp07_pretraining" ]; then
    git mv "$SRC/tp09_transformers" "$SRC/tp07_pretraining" 2>/dev/null \
        || mv "$SRC/tp09_transformers" "$SRC/tp07_pretraining"
    echo "    renamed: tp09_transformers → tp07_pretraining"
fi

move_if_exists \
    "$SRC/tp07_pretraining/tp09_transformers.ipynb" \
    "$SRC/tp07_pretraining/tp07_pretraining.ipynb"

move_if_exists \
    "$SRC/tp07_pretraining/tp09_sol_transformers.ipynb" \
    "$SRC/tp07_pretraining/tp07_sol_pretraining.ipynb"

echo ""

# =============================================================================
# Step 7 — Create tp08_ner_decoding (new session — stub only)
# =============================================================================
echo "── Step 7: create tp08_ner_decoding stub"

mkdir -p "$SRC/tp08_ner_decoding"

if [ ! -f "$SRC/tp08_ner_decoding/.gitkeep" ]; then
    touch "$SRC/tp08_ner_decoding/.gitkeep"
    echo "    created stub: tp08_ner_decoding/"
fi

echo ""

# =============================================================================
# Step 8 — Ensure utils/ exists
# =============================================================================
echo "── Step 8: ensure utils/ exists"

mkdir -p "$SRC/utils"
if [ ! -f "$SRC/utils/__init__.py" ]; then
    touch "$SRC/utils/__init__.py"
    echo "    created: utils/__init__.py"
fi

echo ""

# =============================================================================
# Final summary
# =============================================================================
echo "==> Done. Final structure of src/:"
echo ""
find "$SRC" -maxdepth 2 \( -name "*.ipynb" -o -name "*.py" -o -name ".gitkeep" \) \
    | sort \
    | sed "s|$SRC/||"

echo ""
echo "==> Next steps:"
echo "    1. Review:  git status"
echo "    2. Check:   git diff --stat"
echo "    3. Commit:  git add -A && git commit -m 'refactor: reorganise to 8-session structure'"
echo "    4. Create the new tp03_classical_models notebook (replaces legacy files)"
echo "    5. Stub notebooks exist in tp05-tp08 — fill them in per session"
