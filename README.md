# NeverWake
* Stop Windows from randomly waking up from sleep.
* Stop Windows from killing your laptop by trying to install updates in your backpack.
* Stop Windows from waking *you* up at night by spinning your gamer fans to 100.

## Does What?
Simple script that sends your PC back to sleep if the wakeup source was **not** `Power Button`.
For me, `powercfg -lastwake` always reports the wake source as `Power Button` regardless of if its opening the lid, mashing the keyboard, or doing exactly that.
If yours reports something different, make an issue/pull request and I'll add it as one of the acceptable wakeup reasons.

## How to Install

1. Sleep your pc and wake it up again.
1. Download the [PsShutdown](https://docs.microsoft.com/en-us/sysinternals/downloads/psshutdown) utility from Microsoft and add it to the %PATH%.
1. **Run `Test.bat` to make sure everything is ok. Failure to do so may result in a semi boot loop. Fixable, but obnoxious**
1. Open the event viewer. Windows logs -> System -> Find the `Power-Troubleshooter` event indicating your PC woke up from sleep.
1. Right-click -> Attach task to this event.
1. For the action, do `Start a Program` and browse for `NeverWake.bat`
1. Check `Open the properties dialog when I click Finish`
1. Check `Run whether user is logged on or not`
1. Under conditions, *uncheck* `Start the task on if computer is on AC power` and hit OK.
1. Done. Your PC should now go back to sleep if a Windows service or any other program wakes it up.

## Help! Computer always sleeps when I wake it up

To fix this you either have to [boot into safe mode](https://support.microsoft.com/en-us/help/12376/windows-10-start-your-pc-in-safe-mode) or just **power down and restart your pc completely** (as a cold boot will not fire the power-troubleshooter event).
