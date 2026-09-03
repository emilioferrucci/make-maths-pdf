# make-maths-pdf

`make-maths-pdf` is an explicit-only Codex skill that turns a folder of mathematical ChatGPT transcripts—in PDF, Markdown, or other readable formats—into a coherent, self-contained LaTeX document. It creates or uses a dedicated LaTeX project folder inside the working root, then keeps the source, PDF, bibliography, and other document files together there.

The output is a full-content synthesis, not a condensed account. The skill reads the complete chat corpus first, identifies overlapping and branched discussions, and reorganizes all distinct mathematical content into an organic exposition for the person who asked the original questions.

The main use case is creating a persistent and coherent document that captures the user's full exploration of a new area of mathematics. A typical workflow begins in browser chat: the user provides sources and surveys a subject interactively. The chats are then exported, for example with a plugin, and the Codex/ChatGPT app uses those transcripts to produce the document locally.

## What it does

- reads every transcript before outlining or drafting;
- infers the intended audience, emphasis, notation, and rigor from the questions;
- removes repetition from overlapping or branched chats while preserving every distinct mathematical contribution;
- lets later follow-ups improve the treatment of earlier topics;
- asks for clarification before writing when an important choice or mathematical error needs the user's input;
- preserves an existing LaTeX project's conventions and unrelated sections;
- keeps every document-owned file in one LaTeX project folder inside the working root;
- supports small reader-driven refinements while preserving the transcript-derived structure;
- uses user-supplied sources and BibTeX citations by default;
- compiles with `pdflatex` and checks the resulting PDF.

## Suggested folder layout

```text
project-root/
|-- chats_topic-name/
|   |-- chat-01.pdf
|   |-- chat-02.md
|   `-- branched-chat.html
|-- sources/
|   |-- reference-book.pdf
|   `-- review-article.pdf
`-- latex_topic-name/
    |-- main.tex
    |-- references.bib
    |-- figures/            optional
    |-- sections/           optional
    `-- main.pdf
```

Name the transcript folder `chats` or `chats_<topic>`. It may contain PDF, Markdown, plain-text, HTML, or other readable transcript exports. Supporting books and papers should live in separate folders inside the project root so they are not mistaken for transcripts. Supply an existing LaTeX project folder at invocation, or let the skill create `latex_<topic>` from the selected transcript folder. The skill does not place `.tex`, `.bib`, PDF, or build files loose in the working root.

## Invocation examples

Create a new document:

```text
Use $make-maths-pdf on chats_spectral-sequences. Create a new project in latex_spectral-sequences, write a self-contained survey, use the notation from the transcripts, and omit the discussion of computational software.
```

Fill an existing section:

```text
Use $make-maths-pdf on chats_markov-processes. Use the existing project in latex_markov-notes and add the material to the section “Invariant measures” in latex_markov-notes/notes.tex. Use P for the transition kernel and cite the sources in sources/.
```

Resolve an explicit scope choice:

```text
Use $make-maths-pdf on chats_derived-categories. Cover the motivation and core definitions, but do not include proofs or the discussion of enhancements.
```

The skill may pause after reading the corpus if it finds a mathematical mistake, incompatible notation, unclear scope, or another decision that would materially affect the document.

## Iterative refinement

After reading the generated PDF, continue using `$make-maths-pdf` to ask questions about it. Asking a question alone does not change the document. When you want the answer incorporated, request a local addition or replacement explicitly:

```text
Use $make-maths-pdf to add the explanation you just gave to the paragraph after Definition 3.2. Preserve the section structure and notation.
```

```text
Use $make-maths-pdf to replace the short discussion of recurrence in Section 4 with the clearer explanation from your last answer.
```

These are refinement passes, not fresh synthesis passes. The main scope, hierarchy, order, and narrative remain anchored in the original chat transcripts. The skill integrates the new answer as ordinary mathematical prose, updates nearby transitions or citations when needed, recompiles the PDF, and leaves unrelated sections alone. If a seemingly local request would require a major redesign, it asks before proceeding.

## Content preservation and redundancy

The skill removes repeated expression, not mathematical information. Repeated questions, common branches, and successive clarifications are consolidated into one well-placed explanation, but every distinct definition, insight, example, caveat, comparison, derivation, and notation decision is retained unless the invocation explicitly excludes it or the user approves a correction. The resulting document is not expected to be shorter than the chats; its purpose is completeness without repetition.

## Best practices

- State the target transcript folder when more than one is present.
- State the LaTeX project folder when you already have one. For an existing document, name its main `.tex` file and the section to edit.
- If no LaTeX project folder is supplied, the skill creates `latex_<topic>` inside the root. Specify another name when preferred.
- Keep `.tex`, `.bib`, figures, included sections, local styles, the compiled PDF, and build artifacts inside the LaTeX project folder.
- Put preferred books and papers in source folders inside the project root. Keep an existing working `.bib` file in the LaTeX project folder when possible; if it is supplied elsewhere, the skill copies or merges the needed entries into the project bibliography. These supplied sources take priority over sources found independently.
- Say which topics to include or exclude. This is especially useful when chats wander into interesting but nonessential side topics.
- Specify notation when you have a strong preference. Otherwise, the skill selects and normalizes a convention based on the chats and any existing document.
- Mention unusual expectations about rigor, length, proofs, examples, or citations. By default, the skill matches the transcripts' level and keeps proofs that the chats actually develop.
- For follow-up revisions, identify the paragraph, definition, theorem, or section to change when possible, and say whether the new answer should be added or should replace existing prose.
- Supply readable transcript exports. Markdown and other text-based formats work directly; scanned or damaged PDFs may require OCR and can lead to a clarification request.
- Keep a backup or version-control commit before asking the skill to edit an existing `.tex` file; its default behavior is to modify that source directly.

## Citations

Citations are enabled by default and are managed with BibTeX. The priority is:

1. sources explicitly named or supplied by the user;
2. sources already cited in the transcripts;
3. other verified sources, only when the required material cannot be supported by the preferred sources.

The skill does not expand the mathematical program merely because a source contains related material. You can explicitly request a citation-free document when appropriate.

## Requirements

The compilation environment must provide `pdflatex` and `bibtex`. The helper script can build a main file with:

```bash
scripts/build_pdf.sh project-root/latex_topic/main.tex
```

It runs the required LaTeX and BibTeX passes and reports unresolved citations or references.

## Invocation policy

Automatic invocation is disabled. Call the skill explicitly with `$make-maths-pdf`.
