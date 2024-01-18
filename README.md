## fetchsubj42
#### a little tool to fetch all 42 subjects

the tool resides in [./subjects.sh](subjects.sh). in order to use it, you need to set the `$COOKIES` environment variable.

its value can be found in your browser's devtools, by going to the network tab, fetching any resource, and by checking the `user.id` and `_intra_42_session_production` cookies.
e.g. `COOKIES='user.id=...; _intra_42_session_production=...' ./subjects.sh`

the subjects in the repository were fetched on 18/01/24.
