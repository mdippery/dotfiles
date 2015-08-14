echo '.zprofile: This should be read second (login) - will not be read with new shells on Linux (not login)'

# Similar to .zlogin, exception it is sourced before .zshrc. Meant to be
# an alternative to .zlogin for ksh fans; the two should not be used
# together, although they can be.
