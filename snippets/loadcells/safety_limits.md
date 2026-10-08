### Safety Limits

- `force_safety_limit` (default `2000` grams) is the most force allowed on the bed before a probe move starts.  If it is exceeded you get `force of 3000g exceeds force_safety_limit (2000g) before probing!`, this can be caused by the nozzle already resting on the bed or something pushing on the bed.
- `drift_safety_limit` (default `1000` grams) is the most force allowed while probing before it triggers.  If it is exceeded you get `force exceeded drift_safety_limit before triggering!`.
