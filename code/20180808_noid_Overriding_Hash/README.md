# Overriding Hash
I've tried overriding `Object#hash`.
This is impractical code to try it.
This is named "shiritori", but the rules are not kept.
Even if you break the rules anytimes, "he" cannot perceive it haha.

## Why creating `Phrase` class by a method?
If `all_adjective_count` parameter is changed, `hash` method is changed
radically, so `Phrase` class seems to become a different class.
By using the method, different `Phrase` class can be created whenever `hash`
method is changed.
