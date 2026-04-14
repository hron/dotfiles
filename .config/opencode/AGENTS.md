# Global Agent Instructions

## Formatting — Rust

Whenever you modify any Rust source or manifest files (`*.rs`, `Cargo.toml`), run:

```
cargo fmt
```

in the repository root before considering the task complete. Ensure `rustfmt` is available (`rustup component add rustfmt`).

## MCP — Chrome DevTools with Brave Browser

The `chrome-devtools-mcp` tool expects Google Chrome but the user runs **Brave Browser**.
The MCP tool's `list_pages`, `take_snapshot`, `take_screenshot`, etc. will fail with
`Could not find Google Chrome executable` because Brave's binary is at `/opt/brave-bin/brave`.

**Workaround:** Connect to Brave directly via the Chrome DevTools Protocol (CDP) over WebSocket:

1. The user must start Brave with `--remote-debugging-port=9222`.
2. Verify the port is open: `ss -tlnp | grep 9222`
3. List available targets: `curl -s http://127.0.0.1:9222/json/list | python3 -m json.tool`
4. Find the target page's `webSocketDebuggerUrl` from the JSON output.
5. Use a Python script with the `websockets` library to connect and send CDP commands:

```python
import json, asyncio, websockets

async def main():
    ws_url = "ws://127.0.0.1:9222/devtools/page/<PAGE_ID>"
    async with websockets.connect(ws_url, max_size=10*1024*1024) as ws:
        # Evaluate JavaScript on the page
        msg = json.dumps({
            "id": 1,
            "method": "Runtime.evaluate",
            "params": {
                "expression": "document.title",
                "returnByValue": True
            }
        })
        await ws.send(msg)
        resp = await ws.recv()
        print(json.loads(resp))

asyncio.run(main())
```

**Common CDP methods:**
- `Runtime.evaluate` — run JS on the page (use `returnByValue: True` for serialisable results)
- `Page.captureScreenshot` — take a screenshot (returns base64 PNG; decode and save to file)
- `DOM.getDocument` / `DOM.querySelectorAll` — query the DOM tree

Always prefer `Runtime.evaluate` with a self-contained IIFE for DOM inspection since it
gives the most flexibility and avoids multiple round-trips.

## Todoist Testing

When testing the Todoist Keyboard Add-ons extension via CDP, always use the **Test** project task:

- **URL:** `https://app.todoist.com/app/task/foo-6gMG78G6rqMQWXcH`
- **Project:** Test (`https://app.todoist.com/app/project/test-6gMG786q7CmRV4GH`)

Never test against the user's real projects (e.g. Life).

## Reloading Extensions

The user has an **Extension Reloader** browser extension with the keyboard shortcut **Alt+Shift+R**.
To reload all unpacked extensions and refresh the active tab in one step, dispatch this key combo
via CDP `Input.dispatchKeyEvent` on the Todoist page:

```python
for etype in ['keyDown', 'keyUp']:
    msg = json.dumps({'id': 1, 'method': 'Input.dispatchKeyEvent', 'params': {
        'type': etype,
        'key': 'r',
        'code': 'KeyR',
        'windowsVirtualKeyCode': 82,
        'modifiers': 9,  # 1=Alt + 8=Shift
    }})
```

After sending the combo, wait **~5 seconds** for the extension to reload and the page to refresh
before interacting.
