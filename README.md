<a href="https://oscar-defelice.github.io">
<img src="https://user-images.githubusercontent.com/49638680/98257151-9f5e5800-1f7f-11eb-9f42-479a4fc6cf24.png" height="125" align="right" />
</a>

# Natural Language Processing — Course Material

<p align="center">
<img src="img/image.png" width="700" />
</p>

This repository contains the material for a **30-hour course in Natural Language Processing (NLP)**,
organised as **8 sessions** of ~3 hours each, combining theoretical foundations (~1h) and
hands-on practical sessions (*travaux pratiques*, ~2h).

The course follows a progressive path:
**symbolic methods → probabilistic models → classical ML → neural networks → transformers**,
with a strong emphasis on *building things from scratch* and *controlled empirical comparison*.

This course is part of a broader series of lecture modules:

1. [Introduction to Data Science](https://oscar-defelice.github.io/DSAcademy-lectures) 🧮
2. [Statistical Learning](https://oscar-defelice.github.io/ML-lectures) 📈
3. [Time Series](https://oscar-defelice.github.io/TimeSeries-lectures) ⌛
4. [Computer Vision Hands-On](https://oscar-defelice.github.io/Computer-Vision-Hands-on) 🕶️
5. [Recommender Systems](https://oscar-defelice.github.io/Recommender-Systems-Course) 🚀
6. [Deep Learning](https://oscar-defelice.github.io/DeepLearning-lectures) 💬

---

## Course structure

Each session is organised as:

- **~1h theory** — concepts, intuitions, live demos
- **~2h practical session (TP)** — guided implementation with a concrete deliverable

The practical sessions are **cumulative**: students progressively build a reusable NLP pipeline
rather than starting from scratch at every step. The same benchmark dataset is used from
Session 1 through Session 5, enabling direct comparison of every technique.

### Session outline

| # | Title | Key concepts | Deliverable |
|---|-------|-------------|-------------|
| 01 | [Tokenisation, Normalisation & Baselines](#session-01) | Text normalisation, tokenisation strategies, dataset hygiene, majority baseline | Tokeniser comparison table + baseline metrics |
| 02 | [Language Models & N-grams](#session-02) | Chain rule, n-gram LMs, smoothing, perplexity, BPE | Perplexity results + BPE walkthrough |
| 03 | [Classical Text Classification](#session-03) | TF-IDF, Naive Bayes, logistic regression, SVM, interpretability | Best config + top features + confusion matrix |
| 04 | [Word Embeddings](#session-04) | Distributional hypothesis, Word2Vec, GloVe, polysemy limits | TF-IDF vs embeddings comparison |
| 05 | [Recurrent Neural Networks](#session-05) | Sequences, LSTM/GRU, vanishing gradients, batching & masking | Training curves + error analysis |
| 06 | [Transformer Architecture](#session-06) | Self-attention, multi-head attention, positional encoding | Attention visualisation notebook |
| 07 | [Pre-training & Fine-tuning](#session-07) | BERT, GPT, masked LM, transfer learning, HuggingFace Trainer | Fine-tuned classifier + ablation report |
| 08 | [Token Classification & Decoding](#session-08) | NER, BIO tagging, subword alignment, decoding strategies | NER F1 + decoding comparison |

---

## Repository structure

```
nlp-course/
│
├── data/                          # datasets (raw, processed, datasheets)
├── img/                           # images used in README and notebooks
│
├── src/
│   ├── tp01_tokenization/
│   │   ├── tp01_tokenization.ipynb        # student notebook
│   │   └── tp01_sol_tokenization.ipynb    # solution  (release after session)
│   │
│   ├── tp02_lm_ngrams/
│   │   ├── tp02_lm_ngrams.ipynb
│   │   ├── tp02_sol_lm_ngrams.ipynb
│   │   └── ngram_lm.py                    # n-gram LM implementation
│   │
│   ├── tp03_classical_models/
│   │   ├── tp03_classical_models.ipynb
│   │   ├── tp03_sol_classical_models.ipynb
│   │   ├── naive_bayes.py                 # Naive Bayes from scratch
│   │   └── logistic_regression.py         # logistic regression helpers
│   │
│   ├── tp04_embeddings/
│   │   ├── tp04_embeddings.ipynb
│   │   └── tp04_sol_embeddings.ipynb
│   │
│   ├── tp05_rnn/
│   │   ├── tp05_rnn.ipynb
│   │   └── tp05_sol_rnn.ipynb
│   │
│   ├── tp06_transformer/
│   │   ├── tp06_transformer.ipynb
│   │   └── tp06_sol_transformer.ipynb
│   │
│   ├── tp07_pretraining/
│   │   ├── tp07_pretraining.ipynb
│   │   └── tp07_sol_pretraining.ipynb
│   │
│   ├── tp08_ner_decoding/
│   │   ├── tp08_ner_decoding.ipynb
│   │   └── tp08_sol_ner_decoding.ipynb
│   │
│   └── utils/                     # shared helpers (metrics, data loading, training loops)
│       └── __init__.py
│
├── .github/                       # CI / issue templates
├── .gitignore
├── Dockerfile
├── Makefile
├── environment.yml
├── requirements.txt
├── requirements-macm1.txt
└── README.md
```

### Notebook conventions

- **Student notebooks (`tpXX_*.ipynb`)** — theory cells are complete; code cells contain
  `# YOUR CODE HERE` stubs with type hints and docstrings. Students fill in the logic, not boilerplate.
- **Solution notebooks (`tpXX_sol_*.ipynb`)** — identical structure, all stubs implemented.
  Released after each session. Include an **Instructor notes** cell with expected results,
  common mistakes, and a timing guide.
- **`.py` companion modules** — present only when meaningful reusable code exists
  (e.g. `ngram_lm.py`, `naive_bayes.py`). Not every session requires one.

---

## Companion material

The following notebook is used as a **lecture companion** in Session 02.
It is a conceptual walkthrough (no code) and does not have a student/solution split.

- [`src/tp02_lm_ngrams/LanguageModels.ipynb`](src/tp02_lm_ngrams/LanguageModels.ipynb) —
  Language models: definition, chain rule, n-gram approximation, smoothing, perplexity.

---

## Getting started

### Option 1 — pip

```bash
git clone https://github.com/oscar-defelice/NLP-Course.git
cd NLP-Course
python -m venv .venv && source .venv/bin/activate   # Windows: .venv\Scripts\activate
pip install -r requirements.txt
jupyter lab src/
```

### Option 2 — conda

```bash
conda env create -f environment.yml
conda activate nlp-course
jupyter lab src/
```

### Option 3 — Docker (zero dependency conflicts)

```bash
make
# Jupyter will be running at http://localhost:8888
```

---

## Running in the cloud

No local setup required — open any notebook directly in your browser:

| Platform | Link |
|----------|------|
| Google Colab | Open a notebook → **File → Open in Colab** |
| Binder | *(badge coming — add after first public push)* |

---

## Your lecturer 👨‍🏫

### [Oscar de Felice](https://oscar-defelice.github.io/)

<a href="https://oscar-defelice.github.io/" target="_blank">
<img src="https://oscar-defelice.github.io/images/OscarAboutMe.png" height="550" />
</a>

I am a theoretical physicist working at the intersection of machine learning,
natural language processing, and computational biology.
I write (occasionally) on [Medium](https://oscar-defelice.medium.com/) and keep
personal open-source projects on [GitHub](https://github.com/oscar-defelice).

📫 [oscar.defelice@gmail.com](mailto:oscar.defelice@gmail.com)

[![GitHub](https://img.shields.io/badge/GitHub-100000?style=plastic&logo=github&logoColor=white)](https://github.com/oscar-defelice)
[![Website](https://img.shields.io/badge/oscar--defelice-oscar-orange?style=plastic&logo=netlify&logoColor=informational)](https://oscar-defelice.github.io)
[![Twitter](https://img.shields.io/badge/-@OscardeFelice-1ca0f1?style=plastic&labelColor=1ca0f1&logo=twitter&logoColor=white)](https://twitter.com/OscardeFelice)
[![LinkedIn](https://img.shields.io/badge/-oscardefelice-blue?style=plastic&logo=Linkedin&logoColor=white)](https://linkedin.com/in/oscar-de-felice-5ab72383/)

---

## Questions & contributions

<p align="center">
<img width="600" alt="questions" src="https://user-images.githubusercontent.com/49638680/167115562-1a780ea9-16d4-408b-a500-cd6ad740983d.png">
</p>

Found a bug or have a question? Please
[open an issue](https://github.com/oscar-defelice/NLP-Course/issues) or
[send an email](mailto:oscar.defelice@gmail.com).

#### Support ☕️

If you find these lectures useful, consider
[buying me a coffee](https://github.com/sponsors/oscar-defelice)!

<p align="center">
<a href="https://github.com/sponsors/oscar-defelice">
<img src="https://raw.githubusercontent.com/oscar-defelice/DeepLearning-lectures/master/src/images/breakfast.gif" width="300">
</a>
</p>

---

<p align="left">
<a href="https://github.com/oscar-defelice/NLP-Course">
<img src="https://img.shields.io/github/stars/oscar-defelice/NLP-Course?style=social">
</a>&nbsp;
<a href="https://oscar-defelice.github.io/NLP-Course">
<img src="https://img.shields.io/badge/website-up-informational?style=social">
</a>
</p>
