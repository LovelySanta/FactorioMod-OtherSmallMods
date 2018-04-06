-- Builder files
require ("prototypes/bugzilla-entities")
require ("prototypes/bugzilla-builder")

--############################################################################--
--##########   BugZilla Biter                                       ##########--
--############################################################################--
require ("prototypes/fart-cloud")
BugzillaBuilder:make_alien(bugzilla_biter)

--############################################################################--
--##########   BugZilla Spitter                                     ##########--
--############################################################################--
require ("prototypes/deadly-landmine")
BugzillaBuilder:make_alien(bugzilla_spitter)
