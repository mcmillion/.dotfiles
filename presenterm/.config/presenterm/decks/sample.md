---
title: presenterm demo
sub_title: terminal slides for meetings
author: Matthew McMillion
theme:
  name: dark
---

What is this?
===

A markdown file rendered as slides, right in your terminal.

- Write slides in plain markdown
- Syntax-highlighted code blocks
- Inline images via kitty's graphics protocol
- Run code **live** during a demo

<!-- end_slide -->

Navigation
===

- `n` / `l` / `→` / `space` — next
- `p` / `h` / `←` — previous
- `g` then number — jump to slide
- `q` — quit
- `e` — show parse errors (if a slide breaks)

<!-- end_slide -->

Bullets reveal one at a time
===

<!-- incremental_lists: true -->

- First point
- Then the next
- And finally this one

<!-- end_slide -->

Code blocks
===

```rust
fn main() {
    println!("highlighted in the terminal");
}
```

<!-- end_slide -->

Live execution
===

Add `+exec` to a fenced block, then press `<C-e>` on the slide to run it.

```bash +exec
echo "ran at demo time:"
date
uname -mrs
```

<!-- end_slide -->

Columns
===

<!-- column_layout: [1, 1] -->

<!-- column: 0 -->

**Left**

- pros
- cons

<!-- column: 1 -->

**Right**

```python
print("side by side")
```

<!-- end_slide -->

Thanks
===

Run your own deck:

```bash
presenterm path/to/deck.md
```
