Sentinel backend documentation

# The Goal
This project aims to simplify scripting sentinel class offensive by creating a class that translates attack choices into an Achaea command, freeing the user from having to worry about command syntax and order.

# Important warning for people who aren't familiar with Lua inheritance
**ONLY USE `sent_att` WHEN INVOKING THE `new` METHOD, SUCH AS `att = sent_att:new()`**
All other methods should be invoked using the instance (`att` in the example above), not the template `sent_att`

# The Template
- The template for sentinel attacks is `sent_att`. This table contains all sorts of methods, dictionaries, and other fields you may need to construct an attack.
- New instances are created using the `sent_att:new()` method
- Generally balanceful actions are selected using `sent_att:act(<action name>, <array of additional arguments>)`
	- any previously selected actions that's incompatible with the current action are automatically overriden
	- <action name> is generally the name of the ability
	- second argument can be omitted if there are not additional arguments
	- Example 1: `sent_att:act("skullbash")`
	- Example 2: `sent_att:act("doublestrike", {"curare", "left leg"})
	- `sent_att:summon(<animal>)` can be used in place of `sent_att:act("summon",{<animal>})`. You are welcome.
	- Basilisk gaze/glare attacks are unified under `sent_att:act("eye",<affliction>)`
	- Order of additional arguments is generally <direction>, <venom>, <limb>
- Balanceless actions can be added using `sent_att:no_bal(<balanceless command>)`
	- some special balanceless commands have their own methods, like `sent_att:enr(<animal>)`, `sent_att:morph(<animal>)`, `sent_att:stand()`, `sent_att:parry()`
- Actual construction and sending of commands is done via `sent_att:commit()` method


## Documentation todo:
- script example
- structure of sent_att
- more detailed explanation of methods