---
name: make-maths-pdf
description: Create or revise a self-contained LaTeX mathematics document from a complete folder of ChatGPT transcript PDFs. Use explicitly when the user wants overlapping or branched mathematical chats synthesized into an organic, cited document and compiled with pdflatex, rather than summarized as conversations.
---

# Make Maths PDF

Turn a corpus of mathematical chat transcripts into a persistent, coherent document for the person who asked the original questions. Treat the chats as research notes about the intended subject, audience, notation, and depth—not as a sequence to reproduce.

## Establish the assignment

1. Resolve the working root and the selected transcript folder. Transcript folders are named `chats` or `chats_<topic>`. If more than one could apply and the invocation does not select one, ask which to use.
2. Identify whether the user wants a new document or an edit to an existing `.tex` document. If several possible main files exist or the requested insertion point is unclear, ask before editing.
3. Inventory user-supplied source folders, existing `.bib` files, figures, and the LaTeX project's structure. Do not treat supporting mathematical PDFs as chat transcripts merely because they are PDFs.
4. Extract and read every PDF in the selected transcript folder, recursively, before outlining or writing. Use visual inspection or OCR when ordinary text extraction is incomplete. If a transcript cannot be read reliably, report that before writing.
5. Record the invocation's requirements about topics, exclusions, notation, organization, rigor, citations, and the target section. These instructions take priority over defaults inferred from the corpus.

Do not begin drafting while some transcripts remain unread. Reading the corpus is a global analysis phase, not an incremental write-as-you-read process.

## Synthesize the whole corpus

Build an internal concept map across all chats before deciding on the document structure.

- Use the user's questions to infer their background, motivations, points of confusion, preferred explanations, and desired level of detail.
- Detect common trunks and overlapping passages in branched chats. Merge repeated material semantically; do not repeat a definition, explanation, or example merely because it occurs in several files.
- Let later follow-up questions improve earlier material. They may require a clearer explanation, a deeper treatment, a new topic, a correction, a notation change, or a different ordering.
- Prefer the clearest, most complete, and mathematically correct version when chats contain competing explanations. Reconcile compatible versions into one exposition.
- Organize by mathematical dependencies and pedagogical coherence, not transcript order, file order, or frequency of repetition.
- Identify mathematical errors, contradictory claims, conflicting notation, genuine gaps, and requests that cannot all be satisfied.

Apply this priority order when resolving choices:

1. The current invocation's explicit instructions.
2. Conventions and constraints in the supplied LaTeX project.
3. Mathematical correctness and internal consistency.
4. Preferences and explanations inferred from the transcripts.

## Pause when clarification would improve the result

After reading the whole corpus, ask focused questions without hesitation whenever the answer would materially change the document. In particular, pause before writing when:

- the transcripts contain a substantive mathematical mistake; explain it concisely and propose a correction;
- scope, notation, audience, structure, or the target section remains consequentially ambiguous;
- sources or transcript folders have conflicting roles;
- a requested choice conflicts with the supplied document;
- a transcript is unreadable or incomplete;
- producing a self-contained account appears to require a substantive mathematical topic, theorem, example, or proof outside the program established by the chats.

Wait for the user's response in these cases. Do not ask perfunctory questions when the corpus and invocation already determine a sound answer. Editorial connective material does not require approval.

## Write an organic mathematical document

The result must read as an independently conceived mathematical text.

- Do not include the original questions, a Q&A structure, dialogue, transcript chronology, references to chats, or phrases such as “as discussed.”
- Do not preserve distinctive conversational sequencing or repetition from which the source questions or branching history could be reconstructed.
- Make the document self-contained at the level appropriate to the inferred reader.
- Use smooth transitions, consolidated definitions, short reminders, and connective explanations freely. Reorder material as needed.
- Match the rigor of the transcripts. For a survey-style corpus, emphasize definitions, intuition, notation, relationships, and informative examples rather than adding many proofs.
- Include proofs that appear in the transcripts unless the user excludes them or a correction makes them unusable. Do not add substantial proofs merely for formality.
- Normalize notation throughout. Follow invocation-specific notation first, then the supplied project's notation; otherwise select one coherent convention informed by the chats.
- Do not broaden the mathematical program merely because external references contain related material.

For an existing project, edit the supplied `.tex` source directly, preserve unrelated material, match its macros and style, and integrate the new prose into the requested section. For a new document, default to a clean `article`-class file using pdflatex-compatible mathematics packages, omit the author unless supplied, and choose a structure suited to the topic.

## Use citations and BibTeX by default

Create a properly cited document unless the user explicitly asks for a citation-free treatment.

1. Give first precedence to sources the user identifies or supplies inside the working root.
2. Next, use sources already cited in the transcripts when they can be identified and verified.
3. Consult and cite a different source only when the needed material cannot reasonably be found in the preferred sources. Do not use this permission to expand the document's scope.

Inspect a source before relying on it. Never invent bibliographic metadata, page numbers, theorem numbers, quotations, or support that the source does not provide. Use pinpoint citations when they materially help the reader.

Maintain references in a BibTeX `.bib` file and cite them with ordinary LaTeX citation commands. Preserve an existing bibliography system when it already uses BibTeX. For a new document, default to a conventional BibTeX setup such as `\bibliographystyle{plain}` and `\bibliography{references}`. Do not switch the project to biblatex/Biber unless the user requests it.

External sources may also be consulted for verification. If they reveal a material error, use the clarification gate before drafting. Prefer supplied sources for the final citations whenever they support the relevant claim.

## Compile and verify

Compile with `pdflatex` and BibTeX. The bundled `scripts/build_pdf.sh` performs the normal compilation sequence and fails on unresolved references or citations:

```bash
scripts/build_pdf.sh path/to/main.tex
```

Before finishing:

- confirm the PDF was produced from the current sources;
- resolve compilation errors, undefined citations, undefined references, and materially bad layout warnings;
- inspect the rendered PDF for clipped equations, broken tables, poor page breaks, malformed bibliography entries, and inconsistent section styling;
- spot-check mathematical notation and cross-references against the source;
- ensure the document contains no conversational residue or duplicated branch material.

## Report the result

Give the user the paths to the `.tex`, `.bib`, and PDF outputs. Briefly report:

- the resulting organization and any significant overlap that was consolidated;
- mathematical corrections made with the user's approval;
- meaningful omissions or scope decisions;
- any outside sources used because the preferred sources were insufficient;
- unresolved issues or compilation warnings.

Keep this provenance report in the conversation, not in the mathematical document.
