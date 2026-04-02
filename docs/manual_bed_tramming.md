# Manual Bed Tramming

Before running an **Automatic Bed Mesh**—especially when using high-speed eddy current sensors like the **BTT Eddy, Cartographer, or Beacon**—it is critical to ensure the bed is physically "trammed" (leveled).

If the bed is severely tilted, the sensor or nozzle may collide with the build plate during the scanning process, potentially damaging your hardware.

For more information, refer to [How can I make sure my bed is level / trammed?](faq.md#how-can-i-make-sure-my-bed-is-level-trammed)

## The Manual Tilt Test

This test confirms that your bed is level enough to safely allow the printer to take over.

### 1. Prepare the Machine
* **Home the printer:** Run a `G28` command.
* **Position the Nozzle:** Move the toolhead to the **Front-Left** corner.
* **Set Reference Height:** Lower the Z-axis until the nozzle is roughly **1mm** (or about the thickness of a credit card) above the bed.

### 2. The "Slide & Glide" Check
* **Unlock Motors:** Send the command `M84` to disable the motors.
* **Manual Move:** Gently and slowly slide the toolhead by hand to each of the four corners of the bed.

### 3. Evaluate the Results

| Observation | Meaning | Required Action |
| :--- | :--- | :--- |
| **Uniform Gap** | The nozzle stays ~1mm away from the bed in all corners. | **Safe.** You are ready to run your Bed Mesh. ✅ |
| **Widening Gap** | The nozzle gets much higher as you move. | **Adjustment Needed.** The bed is too low in those areas. |
| **Contact/Collision** | The nozzle touches or scrapes the bed before reaching a corner. | **CRITICAL.** Do NOT run a bed mesh. You must manually level the bed first. ❌ |

## Why This Matters

Eddy current sensors are **fixed-mount**. Unlike a BL-Touch, they do not retract. If your bed is tilted by several millimeters:

- The "low" side of the bed might calibrate correctly.
- As the printer moves to the "high" side, the slope of the bed may rise faster than the printer expects.
- The sensor housing or the nozzle may **crash** into the bed at high speed.

!!! note 

    If you cannot move the nozzle to all four corners manually without hitting the bed, use your bed's adjustment knobs to bring the corners into a roughly level state before attempting any software-based calibration.
