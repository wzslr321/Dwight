# Dwight

**Dwight is a Claude Code agent specialised in turning raw course material into a single,
beautiful, exam-ready PDF of study notes — typeset in LaTeX.**

Point it at a folder of lecture slides, a textbook and a past exam; get back a publishable handbook
with definitions, worked examples, hand-drawn diagrams, model exam answers, a fully solved sample
exam and a one-page cheat sheet. The goal is simple: *a student passes the exam using your PDF alone.*

> Assistant **to** the regional note-maker. Diligent, thorough, slightly obsessed with getting every
> definition exactly right. Fact.

---

## What you get

- 📚 **A repeatable methodology** (`CLAUDE.md`) — how to ingest sources, structure the notes, build
  and visually verify the PDF. This is what makes the output consistently good.
- 🎨 **A reusable LaTeX style** (`templates/dwightnotes.sty`) — a polished design system: callout
  boxes (Definition / Example / Formula / Note / On-the-exam), TikZ/forest/pgfplots diagrams,
  title page, themed headings, cheat-sheet layout. English by default, `[polish]` (and other
  languages) one option away.
- 🧰 **A ready skeleton** (`templates/template.tex`) and a **build script** (`scripts/build.sh`).
- 🤖 **Subagents & a command:** `source-extractor` (reads huge PDFs and returns a structured
  report), `latex-reviewer` (visual + structural QA), and `/notes <folder>` to run the whole flow.

## Requirements

- A full **TeX Live** (provides `tcolorbox`, `tikz`, `forest`, `pgfplots`, `fontawesome5`, `babel`).
- `pdflatex`, `pdfinfo`, `pdftoppm` on `PATH` (poppler). `pandoc`/`textutil` for `.docx` sources.
- [Claude Code](https://claude.com/claude-code).

Check your setup:
```bash
which pdflatex pdfinfo pdftoppm
kpsewhich tcolorbox.sty tikz.sty forest.sty fontawesome5.sty
```

## Quickstart

```bash
# 1. Drop your course material somewhere local (kept out of git):
mkdir -p sources && cp ~/Downloads/course/* sources/

# 2. In Claude Code, from the repo root:
/notes sources my-subject

# …or do it by hand:
cp templates/dwightnotes.sty templates/template.tex .
# edit template.tex -> notes.tex, write the chapters, then:
./scripts/build.sh notes.tex
```

Want Polish (or another language) notes? Use the package option:
```latex
\usepackage[polish]{dwightnotes}
```

## How it works (the short version)

1. **Read everything first** — past exam (defines the questions), syllabus (defines the outline),
   then the material. Huge unordered PDFs are farmed out to the `source-extractor` subagent.
2. **Outline** chapters to the course's own topic structure; guarantee every exam question has an answer.
3. **Write** with the design system — definition → worked example → exam tip; tables and diagrams over prose.
4. **Verify by looking** — compile, scan the log for errors/overfull boxes, render pages to images and read them.
5. **Finish** with a solved sample exam and a cheat sheet. Build twice, clean aux files, done.

Full details live in [`CLAUDE.md`](./CLAUDE.md).

## Layout

```
dwight/
├── CLAUDE.md                  # the methodology (read this)
├── README.md
├── .claude/
│   ├── settings.json          # pre-approved LaTeX tooling permissions
│   ├── agents/                # source-extractor, latex-reviewer
│   └── commands/notes.md      # /notes <folder>
├── templates/
│   ├── dwightnotes.sty        # reusable style package
│   └── template.tex           # document skeleton
├── scripts/build.sh           # compile (×2) + quality report + clean aux
└── examples/                  # showcase output(s)
```

## Conventions

- **The repo is authored in English.** Generated *notes* follow the source language (switch via the
  package option) — never half-translate.
- **Source material is copyrighted; it stays out of git** (`sources/`, `input/` are git-ignored).
  Commit your own `.tex`/`.pdf` and the templates.
