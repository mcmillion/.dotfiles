# Shift+Enter in Pi through Ghostty and Herdr

## Finding

Pi binds `shift+enter` to `tui.input.newLine`; unmodified `enter` submits. It needs a distinct modified-key report to tell those inputs apart.

The tracked Ghostty configuration previously overrode the physical key:

```ini
keybind = shift+enter=text:\x1b\r
```

Ghostty's `text:` action sends literal bytes, so this turns Shift+Enter into `ESC` + carriage return rather than allowing Ghostty to negotiate and send a Shift+Enter event. Pi consequently receives an Enter event and submits.

The override was removed. Current Ghostty, Herdr, and Pi support the Kitty keyboard protocol path required to preserve the modifier. Herdr's input encoder specifically emits `ESC [ 13 ; 2 u` for Shift+Enter when that protocol is negotiated; in legacy encoding it reduces it to carriage return.

## Apply and verify

1. Restart Ghostty (or reload its configuration) so the deleted `keybind` takes effect.
2. In a fresh Herdr pane, start Pi and press Shift+Enter: it should insert a newline.
3. If it still submits, update Herdr/Pi and restart the **Herdr server**; an existing server retains its running pane sessions and older input support.

`Ctrl+J` remains Pi's built-in alternate newline shortcut.

## Sources

- [Pi keybindings](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/docs/keybindings.md) — `tui.input.newLine` defaults to `shift+enter` and `ctrl+j`.
- [Pi terminal setup](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/docs/terminal-setup.md) — Ghostty supports the enhanced keyboard protocol Pi uses.
- [Ghostty keybind reference](https://ghostty.org/docs/config/keybind/reference) — `text:` writes configured literal text.
- [Herdr input encoder](https://github.com/herdrdev/herdr/blob/master/src/input/encode.rs) and [keyboard documentation](https://herdr.dev/docs/keyboard/) — protocol-aware modified key encoding, including Shift+Enter.
