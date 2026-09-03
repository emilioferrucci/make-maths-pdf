# make-maths-pdf

`make-maths-pdf` is an explicit-only Codex skill that turns a folder of mathematical ChatGPT transcript PDFs into a coherent, self-contained LaTeX document. It can create a document from scratch or integrate the material into an existing `.tex` project.

The output is not a transcript summary. The skill reads the complete chat corpus first, identifies overlapping and branched discussions, and reorganizes their mathematical content into an organic exposition for the person who asked the original questions.

## What it does

- reads every transcript before outlining or drafting;
- infers the intended audience, emphasis, notation, and rigor from the questions;
- merges duplicated material from overlapping or branched chats;
- lets later follow-ups improve the treatment of earlier topics;
- asks for clarification before writing when an important choice or mathematical error needs the user's input;
- preserves an existing LaTeX project's conventions and unrelated sections;
- uses user-supplied sources and BibTeX citations by default;
- compiles with `pdflatex` and checks the resulting PDF.

## Suggested folder layout

```text
project-root/
|-- chats_topic-name/
|   |-- chat-01.pdf
|   |-- chat-02.pdf
|   `-- branched-chat.pdf
|-- sources/
|   |-- reference-book.pdf
|   `-- review-article.pdf
|-- references.bib          optional
`-- document.tex            optional; omit for a new document
```

Name the transcript folder `chats` or `chats_<topic>`. Supporting books and papers should live elsewhere in the project root so they are not mistaken for transcripts.

## Invocation examples

Create a new document:

```text
Use $make-maths-pdf on chats_spectral-sequences. Create a self-contained survey, use the notation from the transcripts, and omit the discussion of computational software.
```

Fill an existing section:

```text
Use $make-maths-pdf on chats_markov-processes. Add the material to the section “Invariant measures” in notes.tex. Use P for the transition kernel and cite the sources in sources/.
```

Resolve an explicit scope choice:

```text
Use $make-maths-pdf on chats_derived-categories. Cover the motivation and core definitions, but do not include proofs or the discussion of enhancements.
```

The skill may pause after reading the corpus if it finds a mathematical mistake, incompatible notation, unclear scope, or another decision that would materially affect the document.

## Best practices

- State the target transcript folder when more than one is present.
- For an existing document, name the main `.tex` file and the section to edit.
- Put preferred books, papers, and `.bib` files inside the project root. The skill gives these sources priority over sources it finds independently.
- Say which topics to include or exclude. This is especially useful when chats wander into interesting but nonessential side topics.
- Specify notation when you have a strong preference. Otherwise, the skill selects and normalizes a convention based on the chats and any existing document.
- Mention unusual expectations about rigor, length, proofs, examples, or citations. By default, the skill matches the transcripts' level and keeps proofs that the chats actually develop.
- Supply text-extractable PDFs when possible. Scanned or damaged transcripts may require OCR and can lead to a clarification request.
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
scripts/build_pdf.sh path/to/main.tex
```

It runs the required LaTeX and BibTeX passes and reports unresolved citations or references.

## Invocation policy

Automatic invocation is disabled. Call the skill explicitly with `$make-maths-pdf`.
