# Bunny Hop Rush

A retro DOS game written entirely in x86 16-bit real-mode assembly (NASM). Guide a bunny across a horizontally patrolling slab, timing your jumps to grab fruit and rack up points before you fall or the slab breaks beneath you.

## Gameplay

- The bunny stands on a colored bar that continuously patrols left and right across the screen.
- Press **Up Arrow** to make the bunny hop.
- Land on a fruit (`o`) to score **10 points**.
- The bar cycles through orange, red, and blue. While the bar is **blue**, a countdown starts — jump before it runs out or the brick breaks and it's game over.
- Falling off the slab (missing your landing) also ends the game.
- Your final score is shown on the Game Over screen.

## Controls

| Key | Action |
|-----|--------|
| `Up Arrow` | Jump |
| `Esc` | Pause / quit confirmation |
| `Enter` | Confirm on prompts |

## Requirements

- [NASM](https://www.nasm.us/) — to assemble the source into a `.com` executable.
- [DOSBox](https://www.dosbox.com/) — to run the resulting DOS executable (or any other x86 real-mode DOS emulator, e.g. js-dos).

## Building

From the project folder:

```
nasm -f bin -o project.com project.asm
```

This produces `project.com`, a flat 16-bit DOS binary.

## Running

1. Launch DOSBox.
2. Mount the project folder as a drive and switch to it:
   ```
   mount c "path\to\this\folder"
   c:
   ```
3. Run the game:
   ```
   project
   ```

## Project Structure

- `project.asm` — full game source (rendering, input handling via a custom keyboard ISR, collision detection, scoring, and the game-over sequence).
- `project.com` — assembled, ready-to-run DOS executable.

## Known Limitations

- Scores are tracked only for the current run — there is no highscore persistence between sessions.

## Authors

- Aina Aroob (22L-8221)
- Hafsa Feroze (22L-6636)
