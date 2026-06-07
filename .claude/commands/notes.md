---
description: Turn a folder of course material into a complete, exam-ready LaTeX notes PDF.
argument-hint: <path-to-source-folder> [output-name]
---

Produce a complete study-notes PDF from the source material in: **$1**
(output base name, if given: **$2** — otherwise pick a sensible one).

Follow the full Dwight workflow in `CLAUDE.md`. In short:

1. **Ingest everything.** List `$1`. Read the sample/old exam first (convert DOCX with `textutil`
   or `pandoc`), then any syllabus/topics file. Read small PDFs yourself; for large/unordered PDFs,
   launch the `source-extractor` subagent(s) in the background and integrate their reports.
2. **Outline.** Map sources → chapters, mirroring the course's topic numbering. Make sure every
   exam-question type has a home. Flag topics the exam needs but the source omits.
3. **Skeleton.** Copy `templates/template.tex` + `templates/dwightnotes.sty` next to the output
   file. Choose the language option to match the source material. Compile the skeleton first.
4. **Write** chapters using the callout boxes; tables for comparisons, TikZ/forest/pgfplots for
   diagrams. Every numeric method → a fully worked example; every exam-question type → an
   `egzaminbox` model answer. Compile every few chapters.
5. **Add** a fully **solved sample exam** chapter and a **cheat-sheet appendix**.
6. **Verify** with the `latex-reviewer` subagent (or the checks in `CLAUDE.md`): no errors, no
   undefined refs, no bad overfull boxes; render and read key pages. Fix issues.
7. **Finalise** with `./scripts/build.sh <output>.tex` and report the page count + what's covered.

Do not commit copyrighted source files. Keep all repo-authored text in English; the generated notes
follow the source language.
