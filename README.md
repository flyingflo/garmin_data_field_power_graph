# Power Graph

This data field shows the current power and draws a graph with recent values in the background.

- configurable value smoothing: average 10s, 5s, 3s, or none.
- background graph draws history, one pixel per second.
- configurable min, max, and threshold.
- three graph colors: below threshold, above threshold, above max.
- dedicated color palette for day and night mode.
- optimized battery consumption: keeps the graph in an offscreen bitmap to avoid full redraws (full redraws are 10x slower).

Testing settings:

- Demo mode: shows a linear ramp to test color palettes.
- Timing: Display the graph redraw time in milliseconds in the field label. It's about 20ms on the Edge 820.
