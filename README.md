# NWVars Instructions

Edit the InitNetworkVars table in lua/nwvars/server/server_priority/init.lua to initialize any variables that you want to use.
Uninitialized variables won't be recognized.

These functions are designed to allow networked variables to be set on the server, received on the client, and called on both.

All setNW_ functions take a string argument as the ID, and a value that matches the type of the function. These functions can only be called on the server.
For PLAYER:setNWInt(), you can specify an optional third argument, size = number of bits (3-32). Default size = 10.

All getNW_ functions take a string argument as the ID, and can be called on the client and the server.

# Currently Supported:
NWFloat
NWInt
NWBool
NWString
NWTable
