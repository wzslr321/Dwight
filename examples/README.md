# Examples

- **`sample.pdf`** — the rendered `templates/template.tex` (English). It shows the design system at
  a glance: the cover banner, the five callout boxes (Definition / Formula / Example / Note /
  On-the-exam), a TikZ diagram, and the chapter/heading styling. Rebuild it with:
  ```bash
  cp templates/dwightnotes.sty .          # put the style on the path
  ./scripts/build.sh templates/template.tex
  ```

Drop your own finished notes here to showcase them. **Do not commit copyrighted source material**
(lecture PDFs, textbooks) — only your generated `.tex`/`.pdf`. Generated notes may be in any
language even though the repo itself is authored in English.
