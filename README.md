
# Gi-Paint

> [!NOTE]
> A pet project I built as part of a challenge. I had 48 hours to learn Lisp/Scheme (which I had never even set eyes on before) and build a Paint app using Guile (without using Racket and AI for writing code)

![](https://github.com/zamirdefis/Gi-Paint/blob/main/preview.png)

## 🔮 Features
- Palette-based color selection in the toolbar
- 3 tools: Brush, Stamp, and Fill
- Eraser mode
- Canvas panning support
- Hotkey-based brush resizing

## 🎛️ Controls
- **Resize Brush:** Hold `LeftShift` + Drag cursor left/right
- **Pan Canvas:** Hold `Middle Click` + Drag
- **Toggle Erase Mode:** Press `E`
- **Tool Shortcuts:**
  - `B` — Brush
  - `F` — Fill
  - `S` — Stamp

## 📦 Dependencies

Install these dependencies before running:
- Raylib _(`sudo pacman -S raylib`)_
- Guile _(`sudo pacman -S guile`)_

## 🚀 Run

_Ensure that all dependencies from the "Dependencies" section are installed_

```sh
cd Gi-Paint
chmod +x main.scm
./main.scm
```

<details>
<summary><b> ⚠️ Open issues</b></summary>
<br>
  
- The fill tool is broken
- Buttons trigger not only on click, but also on hover while held down

</details>

