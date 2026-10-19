Flutter Lab — Final Answers

Name: Hamza Afsar  
Roll Number: 04072313001

Part A — Numerical Answers

A1: 16

A2: 7

A3: 6

A4: 20

 Part B — Written Answers

B1: Which classes are Stateless and which are Stateful, and why?**

Stateless classes are `LabApp`, `HomePage`, `StudentCard`, and `GoalBanner`. They display the app structure or information passed to them without storing changing state.

Stateful classes are `Tally`, `Countdown`, and `BuggyCounter`. They need state because the count, timer, or click value changes while the app runs.

B2: Why must the Timer be cancelled in dispose()?**

The timer must be cancelled to stop it from running after the widget is removed. Otherwise, it may try to call `setState()` on a disposed State object and cause an error. Cancelling it also prevents unnecessary background work.

B3: Which widgets can be const, and what does const do?**

`LabApp`, `HomePage`, `Tally`, `Countdown`, and `BuggyCounter` can be created with const constructors. Constant widgets such as `SizedBox`, fixed `Text` widgets, and constant keys can also use `const` where their arguments are constant.

The `const` keyword creates compile-time constants when possible. It avoids recreating equivalent constant widget configurations unnecessarily and can improve code clarity and efficiency.