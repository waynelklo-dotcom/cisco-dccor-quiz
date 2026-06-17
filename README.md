# Cisco 350-601 DCCOR — MC Test Web App

A self-contained multiple-choice test web app built from your PDFs, with exhibit images extracted from the source pages.

## What's here

- **`test.html`** — the web app (open in a browser)
- **`questions.json`** — 573 extracted questions (536 MC + 37 exhibit-type w/o image)
- **`exhibits/`** — 230 cropped exhibit images from the PDFs
- **`merge_questions.py`** — combines/cleans raw question JSON
- **`extract_exhibits.py`** — re-extracts exhibit images from the source PDFs

## How to run

**Easy way:** just double-click `test.html` to open in your browser.

If your browser blocks loading `questions.json` from a `file://` URL, run a tiny local server:

```powershell
# in the folder with test.html:
python -m http.server 8765
```

Then visit <http://127.0.0.1:8765/test.html>.

## Modes

| Mode | What it does |
|------|--------------|
| **Quiz Mode** | One question at a time, instant feedback + explanation. No timer. |
| **Timed Test** | 60 random questions, 90-min countdown. Simulates exam conditions. |
| **Missed Questions** | Drill only the questions you got wrong. |
| **Bookmarked** | Review questions you've starred. |
| **Browse All** | Searchable list of every question with answers. |

## Features

- ⭐ **Bookmarks** — save hard questions for later
- 🚩 **Flags** — mark questions you're unsure about
- 🖼️ **Exhibit images** — for "Refer to the exhibit" questions, the original image from the PDF is shown above the question. Click to zoom.
- 🌓 **Light / dark** theme
- 💾 **Progress saved** in browser localStorage (Seen / Right / Bookmarked counts in header)
- 🔍 **Search** in browse view (matches question + options)
- 🎯 **Filter** by right / wrong / unseen / bookmarked / flagged / MC / has-exhibit
- ⏱ **Timer** in test mode with auto-finish at 0:00
- 📊 **Score breakdown** at the end of every session
- 🔁 **Redo Missed** — replay only what you got wrong

## About the questions

- 573 unique questions after dedup, merged from both PDFs
- **162 questions include the original exhibit image** from the PDF
- Answers and explanations are present for most questions
- 37 "exhibit" type questions show the answer but have no extractable options (image-only content)
- Drag-and-drop questions from the q526 PDF are excluded (would need an interactive drag UI)
- A few questions may have minor OCR artifacts (ligature extraction); corrections are in `merge_questions.py`

## Regenerating the data

If you replace the PDFs, drop them on the desktop and rerun:

```powershell
python extract_exhibits.py   # extracts images from PDFs
python merge_questions.py    # builds questions.json
```

(Each script caches intermediate results so re-runs are fast.)

## Deploy to GitHub Pages

The app is a fully static site, so it's free to host on GitHub Pages.

**First-time setup (one time):**

1. Create an empty repo on github.com (do **not** add README/license/.gitignore)
2. From this folder:
   ```powershell
   git remote add origin https://github.com/waynelklo-dotcom/cisco-dccor-quiz.git
   git push -u origin main
   ```
3. On github.com: **Settings → Pages → Source: `main` / `(root)` → Save**
4. Wait ~1 minute. Site is live at:
   `https://waynelklo-dotcom.github.io/cisco-dccor-quiz/test.html`

**Updating after changes** (questions, exhibits, or test.html):

```powershell
git add .
git commit -m "describe what changed"
git push
```

Or just double-click `deploy.bat` — it does all three.

Custom domain: **Settings → Pages → Custom domain**, then add a CNAME at your DNS provider.
