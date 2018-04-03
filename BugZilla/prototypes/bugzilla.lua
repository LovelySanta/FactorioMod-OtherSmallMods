-- Builder files
require ("prototypes/bugzilla-entities")
require ("prototypes/bugzilla-builder")

--############################################################################--
--##########   BugZilla Biter                                       ##########--
--############################################################################--
require ("prototypes/fart-cloud") -- Used by bugzilla-biter
require ("prototypes/pile-of-poop") -- Used by bugzilla-biter
BugzillaBuilder:make_alien(bugzilla_biter)

--############################################################################--
--##########   BugZilla Spitter                                     ##########--
--############################################################################--
BugzillaBuilder:make_alien(bugzilla_spitter)
