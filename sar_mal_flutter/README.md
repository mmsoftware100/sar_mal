# စားမယ်

##  Bugs

Another exception was thrown: 'package:flutter/src/widgets/framework.dart': Failed assertion: line 4605 pos 12: '_lifecycleState != _ElementLifecycle.defunct': is not true.
 
- [x] ဒီ Error တက်နေတယ်။

```bash
══╡ EXCEPTION CAUGHT BY WIDGETS LIBRARY ╞═══════════════════════════════════════════════════════════
The following assertion was thrown while finalizing the widget tree:
SkeletonState#76005(ticker active) was disposed with an active Ticker.
SkeletonState created a Ticker via its SingleTickerProviderStateMixin, but at the time dispose() was
called on the mixin, that Ticker was still active. The Ticker must be disposed before calling
super.dispose().
Tickers used by AnimationControllers should be disposed by calling dispose() on the
AnimationController itself. Otherwise, the ticker will leak.
The offending ticker was:
Ticker(created by SkeletonState#76005)
The stack trace when the Ticker was actually created was:
#0      new Ticker.<anonymous closure> (package:flutter/src/scheduler/ticker.dart:71:40)
#1      new Ticker (package:flutter/src/scheduler/ticker.dart:73:6)
#2      SingleTickerProviderStateMixin.createTicker
(package:flutter/src/widgets/ticker_provider.dart:199:15)
#3      new AnimationController (package:flutter/src/animation/animation_controller.dart:250:21)
#4      SkeletonState.initState (package:sar_mal_flutter/view/widgets/skeleton.dart:20:19)

```


- [ ] ပုံနှင့်စာ အပြည့်အစုံရှီရန်။
- [ ] Splash Screen Icon -> Copy Right လွတ်ရန်
